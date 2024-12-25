import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_apis/core/auth_helper.dart';
import 'package:tasky_apis/logic/cubit/tasks_cubit.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Logo",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        InkWell(
          onTap: () async {
            Navigator.pushNamed(context, "profile");
          },
          child: Image.asset("assets/images/person.png"),
        ),
        const SizedBox(width: 20),
        InkWell(
            onTap: () {
              // BlocProvider.of<TaskCubit>(context).tasks.clear();
              // TaskyUser.signOut();
              AuthHelper.unauthenticate();
              BlocProvider.of<TasksCubit>(context)
                  .taskCreationRepsonses!
                  .clear();
              BlocProvider.of<TasksCubit>(context).finished!.clear();
              BlocProvider.of<TasksCubit>(context).inProgress!.clear();
              BlocProvider.of<TasksCubit>(context).waiting!.clear();
              AuthHelper.routeAuthenticatedUser(context, () {
                Navigator.pushReplacementNamed(context, "login");
              });
            },
            child: Image.asset("assets/images/exit.png")),
        const SizedBox(width: 20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 50);
}
