import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:tasky_apis/core/constants/structures.dart';
import 'package:tasky_apis/data/models/task_creation_response.dart';
import 'package:tasky_apis/logic/cubit/tasks_cubit.dart';
import 'package:tasky_apis/presentation/widgets/StatusChoice.dart';
import 'package:tasky_apis/presentation/widgets/aerror_widget.dart';
import 'package:tasky_apis/presentation/widgets/primary_appbar.dart';
import 'package:tasky_apis/presentation/widgets/task_element.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List<TaskCreationResponse> taskCreationResponse = [];
  int activeStatus = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TasksCubit>(context).getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is TasksLoaded) {
            if (activeStatus == 0) {
              taskCreationResponse = state.taskCreationResponse;
            } else if (activeStatus == 1) {
              taskCreationResponse = state.taskCreationResponse
                  .where((task) => task.status == 'inProgress')
                  .toList();
            } else if (activeStatus == 2) {
              taskCreationResponse = state.taskCreationResponse
                  .where((task) => task.status == 'waiting')
                  .toList();
            } else if (activeStatus == 3) {
              taskCreationResponse = state.taskCreationResponse
                  .where((task) => task.status == 'finished')
                  .toList();
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    const Text(
                      "My Tasks",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                        onTap: () {
                          BlocProvider.of<TasksCubit>(context).getTasks();
                        },
                        child: const Icon(Icons.refresh))
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(taskStatus.length, (index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (index == 0) {
                            activeStatus = 0;
                            taskCreationResponse =
                                BlocProvider.of<TasksCubit>(context)
                                    .taskCreationRepsonses!;
                          } else if (index == 1) {
                            activeStatus = 1;
                            taskCreationResponse =
                                BlocProvider.of<TasksCubit>(context)
                                    .inProgress!;
                          } else if (index == 2) {
                            activeStatus = 2;
                            taskCreationResponse =
                                BlocProvider.of<TasksCubit>(context).waiting!;
                          } else if (index == 3) {
                            activeStatus = 3;
                            taskCreationResponse =
                                BlocProvider.of<TasksCubit>(context).finished!;
                          }
                        });
                      },
                      child: StatusChoice(
                        isActive: index == activeStatus,
                        name: taskStatus[index],
                      ),
                    );
                  })
                ],
              ),
              const SizedBox(height: 20),
              // if (state is TasksLoaded)
              if (taskCreationResponse.isNotEmpty)
                Expanded(
                  child: ListView(
                    children: taskCreationResponse.map((task) {
                      return TaskElement(
                        taskCreationResponse: task,
                      );
                    }).toList(),
                  ),
                )
              else if (taskCreationResponse.isEmpty)
                // else if (state is TasksFail)
                //   const AErrorWidget()
                // else if (state is TasksInitial)
                //   const Center(
                //     child: CircularProgressIndicator(),
                //   )
                // else
                Image.asset("assets/images/no-tasks.jpg")
            ],
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(15),
              backgroundColor: const Color(0xffEBE5FF),
              shape: const CircleBorder(),
            ),
            onPressed: () {},
            child: Image.asset(
              "assets/images/qr.png",
              width: 25,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 70,
            height: 70,
            child: FittedBox(
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: const Color(0xff5F33E1),
                onPressed: () {
                  Navigator.pushNamed(context, "add_edit_task");
                },
                child: Image.asset("assets/images/plus.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
