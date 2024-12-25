// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:tasky_apis/core/auth_helper.dart';
import 'package:tasky_apis/core/cache_helper.dart';
import 'package:tasky_apis/data/models/register_request.dart';
import 'package:tasky_apis/data/models/register_response.dart';
import 'package:tasky_apis/data/repositories/register_repository.dart';
import 'package:tasky_apis/data/web_services/register_web_service.dart';
import 'package:tasky_apis/logic/cubit/register_cubit.dart';
import 'package:tasky_apis/presentation/widgets/primary_button.dart';
import 'package:tasky_apis/presentation/widgets/primary_textformfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late RegisterResponse registerResponse;
  @override
  initState() {
    super.initState();
    // BlocProvider.of<RegisterCubit>(context);
  }

  bool passwordObsecutriy = true;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController expCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  final List<String> experienceLevels = [
    'Chose Experience Level',
    'Intermediate',
    'Advanced',
    'Expert',
  ];
  String? selectedLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => RegisterCubit(
            RegisterRepository(registerWebService: RegisterWebService())),
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width / 14,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/ART.png",
                      height: MediaQuery.sizeOf(context).height / 3,
                    ),
                  ),
                  const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  PrimaryTextformfield(
                    obsecure: false,
                    hint: "Name...",
                    controller: nameCtrl,
                  ),
                  const SizedBox(height: 10),
                  PrimaryTextformfield(
                    obsecure: false,
                    hint: "Email...",
                    controller: phoneCtrl,
                  ),
                  const SizedBox(height: 10),
                  PrimaryTextformfield(
                    obsecure: false,
                    hint: "Years of experience",
                    controller: expCtrl,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400, // لون الحدود
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Colors.blue, // لون الحدود عند التركيز
                          width: 1.5,
                        ),
                      ),
                    ),
                    hint: Text(
                      'Choose experience Level',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    value: selectedLevel,
                    icon: Icon(Icons.arrow_drop_down,
                        color: Colors.grey.shade600),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    items: experienceLevels.map((String level) {
                      return DropdownMenuItem<String>(
                        value: level,
                        child: Text(level),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLevel = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  PrimaryTextformfield(
                    obsecure: false,
                    hint: "Address...",
                    controller: addressCtrl,
                  ),
                  const SizedBox(height: 10),
                  PrimaryTextformfield(
                    obsecure: passwordObsecutriy,
                    hint: "Password...",
                    controller: passwordCtrl,
                    suffix: InkWell(
                      child: passwordObsecutriy
                          ? Image.asset(
                              "assets/images/opened-eye.png",
                              height: 20,
                            )
                          : Image.asset(
                              "assets/images/closed-eye.png",
                              height: 20,
                            ),
                      onTap: () {
                        setState(() {
                          passwordObsecutriy = !passwordObsecutriy;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                      onPressed: () async {
                        final registerRequest = RegisterRequest(
                          displayName: nameCtrl.text,
                          address: addressCtrl.text,
                          experienceYears: int.tryParse(expCtrl.text),
                          level: "senior",
                          password: passwordCtrl.text,
                          phone: phoneCtrl.text,
                        );

                        final registerCubit = RegisterCubit.get(context);
                        await registerCubit.register(registerRequest);

                        state = registerCubit.state;
                        if (state is RegisterFail) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
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
                                    style: TextStyle(color: Colors.blueAccent),
                                  )
                                ],
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } else if (state is RegisterSuccess) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.white,
                                elevation: 10,
                                content: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.error,
                                      color: Colors.greenAccent,
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      "Successful Register",
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    )
                                  ],
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        }
                        if (context.mounted) {
                          String token =
                              registerCubit.registerResponse!.accessToken!;
                          String refreshToken =
                              registerCubit.registerResponse!.refreshToken!;
                          AuthHelper.authenticate(token,
                              refreshToken: refreshToken);
                          AuthHelper.routeAuthenticatedUser(context, () {});
                        }
                      },
                      text: "Sign Up"),
                  const SizedBox(height: 10),
                  Center(
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, "login"),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Already have any account? ",
                              style: TextStyle(
                                color: Color(0xff7F7F7F),
                              ),
                            ),
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void authenticationFlow(RegisterResponse? registerResponse) {
    if (registerResponse != null) {
      CacheHelper.create("token", registerResponse.accessToken);
      Navigator.pushReplacementNamed(context, "login");
    }
    // else {
    //   Navigator.pushReplacementNamed(context, "intro");
    // }
  }
}
