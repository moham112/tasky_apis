import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky_apis/core/auth_helper.dart';
import 'package:tasky_apis/core/cache_helper.dart';
import 'package:tasky_apis/core/dio_helper.dart';
import 'package:tasky_apis/data/repositories/auth_repository.dart';
import 'package:tasky_apis/data/repositories/profile_repository.dart';
import 'package:tasky_apis/data/repositories/register_repository.dart';
import 'package:tasky_apis/data/repositories/task_creation_repository.dart';
import 'package:tasky_apis/data/repositories/task_delete_repository.dart';
import 'package:tasky_apis/data/repositories/task_edit_repository.dart';
import 'package:tasky_apis/data/repositories/tasks_repository.dart';
import 'package:tasky_apis/data/web_services/auth_web_service.dart';
import 'package:tasky_apis/data/web_services/profile_web_service.dart';
import 'package:tasky_apis/data/web_services/register_web_service.dart';
import 'package:tasky_apis/data/web_services/task_creation_web_services.dart';
import 'package:tasky_apis/data/web_services/task_delete_webservices.dart';
import 'package:tasky_apis/data/web_services/task_edit_webservice.dart';
import 'package:tasky_apis/data/web_services/tasks_webservice.dart';
import 'package:tasky_apis/logic/cubit/auth_cubit.dart';
import 'package:tasky_apis/logic/cubit/profile_cubit.dart';
import 'package:tasky_apis/logic/cubit/register_cubit.dart';
import 'package:tasky_apis/logic/cubit/task_creation_cubit.dart';
import 'package:tasky_apis/logic/cubit/tasks_cubit.dart';
import 'package:tasky_apis/presentation/screens/ATask.dart';
import 'package:tasky_apis/presentation/screens/add_edit_task.dart';
import 'package:tasky_apis/presentation/screens/intro.dart';
import 'package:tasky_apis/presentation/screens/login.dart';
import 'package:tasky_apis/presentation/screens/profile.dart';
import 'package:tasky_apis/presentation/screens/register.dart';
import 'package:tasky_apis/presentation/screens/splash_screen.dart';
import 'package:tasky_apis/presentation/screens/tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  await AuthHelper.init();

  // bool state1 = await CacheHelper.create("token", "0");
  // bool state2 = await CacheHelper.create("refresh_token", "0");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(
              RegisterRepository(registerWebService: RegisterWebService())),
        ),
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(AuthRepository(authWebService: AuthWebService())),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
              ProfileRepository(profileWebService: ProfileWebService())),
        ),
        BlocProvider<TaskCreationCubit>(
          create: (context) => TaskCreationCubit(
              TaskCreationRepository(TaskCreationWebServices())),
        ),
        BlocProvider<TasksCubit>(
          create: (context) => TasksCubit(
            TasksRepository(tasksWebservice: TasksWebservice()),
            TaskEditRepository(TaskEditWebService()),
            TaskDeleteRepository(
                taskDeleteWebservices: TaskDeleteWebservices()),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "splash",
        routes: {
          "splash": (context) => const SplashScreen(),
          "intro": (context) => const Intro(),
          "login": (context) => const Login(),
          "register": (context) => const Register(),
          "tasks": (context) => const Tasks(),
          "atasks": (context) => const Atask(),
          "add_edit_task": (context) => AddEditTask(),
          "profile": (context) => const Profile(),
        },
      ),
    );
  }
}
