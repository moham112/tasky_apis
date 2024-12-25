// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:logger/logger.dart';

import 'package:tasky_apis/core/auth_helper.dart';
import 'package:tasky_apis/data/models/task_creation_response.dart';
import 'package:tasky_apis/data/repositories/task_delete_repository.dart';
import 'package:tasky_apis/data/web_services/task_delete_webservices.dart';
import 'package:tasky_apis/logic/cubit/tasks_cubit.dart';
import 'package:tasky_apis/presentation/screens/add_edit_task.dart';

class TaskElement extends StatelessWidget {
  TaskCreationResponse taskCreationResponse;
  TaskElement({
    super.key,
    required this.taskCreationResponse,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     // builder: () => Atask()
          //   ),
          // );
        },
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset("assets/images/task_image.png"),
            ),
            const SizedBox(width: 7),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          taskCreationResponse.title!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      TaskStatus(
                          status: toBeginningOfSentenceCase(
                              taskCreationResponse.status!))
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    taskCreationResponse.desc!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      TaskPriority(
                          priority: toBeginningOfSentenceCase(
                              taskCreationResponse.priority!)),
                      const Spacer(),
                      Text(
                        taskCreationResponse.createdAt!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: PopupMenuButton(
                  onSelected: (item) {},
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditTask(
                                taskCreationResponse: taskCreationResponse,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          TaskDeleteRepository(
                                  taskDeleteWebservices:
                                      TaskDeleteWebservices())
                              .deleteTask(taskCreationResponse.sId!);
                          BlocProvider.of<TasksCubit>(context).getTasks();
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ];
                  },
                  child: Image.asset("assets/images/3pts.png")),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskStatus extends StatelessWidget {
  const TaskStatus({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case "Finished":
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffFFE4F2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
            "Finished",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xffFF7D53),
            ),
          ),
        );
      case "InProgress":
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffE3F2FF),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(status,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff0087FF),
              )),
        );
      case "Waiting":
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF0ECFF),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(status,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff5F33E1),
              )),
        );
      default:
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF0ECFF),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(status,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff5F33E1),
              )),
        );
    }
  }
}

class TaskPriority extends StatelessWidget {
  const TaskPriority({
    super.key,
    required this.priority,
  });

  final String priority;

  @override
  Widget build(BuildContext context) {
    switch (priority) {
      case "Low":
        return Row(
          children: [
            Image.asset("assets/images/cyan-flag.png"),
            const SizedBox(width: 5),
            Text(
              priority,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff0087FF),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      case "Medium":
        return Row(
          children: [
            Image.asset("assets/images/violet-flag.png"),
            const SizedBox(width: 5),
            Text(
              priority,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff5F33E1),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      case "High":
        return Row(
          children: [
            Image.asset("assets/images/orange-flag.png"),
            const SizedBox(width: 5),
            Text(
              priority,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xffFF7D53),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      default:
        return Row(
          children: [
            Image.asset("assets/images/cyan-flag.png"),
            const SizedBox(width: 5),
            Text(
              priority,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff5F33E1),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
    }
  }
}
