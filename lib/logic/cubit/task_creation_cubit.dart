import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky_apis/data/models/task_creation_request.dart';
import 'package:tasky_apis/data/models/task_creation_response.dart';
import 'package:tasky_apis/data/repositories/task_creation_repository.dart';

part 'task_creation_state.dart';

class TaskCreationCubit extends Cubit<TaskCreationState> {
  TaskCreationCubit(this.taskCreationRepository)
      : super(TaskInitial(TaskCreationResponse()));

  TaskCreationRepository taskCreationRepository;
  TaskCreationResponse? taskCreationResponse;

  void createTask(TaskCreationRequest taskCreationRequest) {
    emit(TaskInitial(TaskCreationResponse()));

    taskCreationRepository.createTask(taskCreationRequest).then((value) {
      taskCreationResponse = value;
      emit(TaskCreatedSuccess(taskCreationResponse!));
    }).catchError((error) {
      taskCreationResponse = null;
      emit(TaskCreatedFail(taskCreationResponse!));
    });
  }
}
