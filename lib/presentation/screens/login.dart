import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_apis/core/auth_helper.dart';
import 'package:tasky_apis/data/models/auth_request.dart';
import 'package:tasky_apis/logic/cubit/auth_cubit.dart';
import 'package:tasky_apis/presentation/widgets/primary_button.dart';
import 'package:tasky_apis/presentation/widgets/primary_textformfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordObsecurity = true;
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Container(
            margin:
                EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height / 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/ART.png",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width / 11,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 15),
                      PrimaryTextformfield(
                        controller: phoneCtrl,
                        obsecure: false,
                        hint: "Email",
                      ),
                      const SizedBox(height: 10),
                      PrimaryTextformfield(
                        controller: passwordCtrl,
                        obsecure: passwordObsecurity,
                        hint: "Password",
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              passwordObsecurity = !passwordObsecurity;
                            });
                          },
                          child: passwordObsecurity
                              ? Image.asset(
                                  "assets/images/opened-eye.png",
                                  height: 20,
                                )
                              : Image.asset(
                                  "assets/images/closed-eye.png",
                                  height: 20,
                                ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      PrimaryButton(
                          onPressed: () async {
                            AuthRequest authRequest = AuthRequest(
                                phone: phoneCtrl.text,
                                password: passwordCtrl.text);
                            final authCubit = AuthCubit.get(context);
                            await authCubit.auth(authRequest);
                            AuthState currentState = authCubit.state;

                            if (currentState is AuthSuccess) {
                              if (context.mounted) {
                                String token =
                                    authCubit.authResponse!.accessToken!;
                                String refreshToken =
                                    authCubit.authResponse!.refreshToken!;
                                AuthHelper.authenticate(token,
                                    refreshToken: refreshToken);
                                AuthHelper.routeAuthenticatedUser(
                                    context, () {});
                              }
                            } else if (currentState is AuthFail) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.white,
                                    elevation: 10,
                                    content: Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.error,
                                          color: Colors.redAccent,
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          "Faild Register",
                                          style: TextStyle(
                                              color: Colors.blueAccent),
                                        )
                                      ],
                                    ),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            }
                          },
                          text: "Sign In"),
                      const SizedBox(height: 15),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, "register");
                          },
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Didn't have any account? ",
                                  style: TextStyle(
                                    color: Color(0xff7F7F7F),
                                  ),
                                ),
                                TextSpan(
                                  text: "Sign Up here",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.3,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
