part of 'task_creation_cubit.dart';

@immutable
sealed class TaskCreationState {}

final class TaskInitial extends TaskCreationState {
  TaskCreationResponse taskCreationResponse;

  TaskInitial(this.taskCreationResponse);
}

final class TaskCreatedSuccess extends TaskCreationState {
  TaskCreationResponse taskCreationResponse;
  TaskCreatedSuccess(this.taskCreationResponse);
}

final class TaskCreatedFail extends TaskCreationState {
  TaskCreationResponse taskCreationResponse;
  TaskCreatedFail(this.taskCreationResponse);
}
