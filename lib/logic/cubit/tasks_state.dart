part of 'tasks_cubit.dart';

@immutable
sealed class TasksState {}

final class TasksInitial extends TasksState {}

final class TasksEmpty extends TasksState {}

final class TasksLoaded extends TasksState {
  List<TaskCreationResponse> taskCreationResponse;

  TasksLoaded(this.taskCreationResponse);
}

final class TasksFail extends TasksState {
  List<TaskCreationResponse> taskCreationResponse;

  TasksFail(this.taskCreationResponse);
}

final class TaskEditedSuccess extends TasksState {
  TaskCreationResponse taskCreationResponse;

  TaskEditedSuccess(this.taskCreationResponse);
}

final class TaskEditedWait extends TasksState {}

final class TaskEditedFail extends TasksState {
  TaskCreationResponse taskCreationResponse;

  TaskEditedFail(this.taskCreationResponse);
}

final class TaskDeletedSuccess extends TasksState {
  TaskCreationResponse taskCreationResponse;

  TaskDeletedSuccess(this.taskCreationResponse);
}

final class TaskDeletedWait extends TasksState {
  TaskCreationResponse taskCreationResponse;

  TaskDeletedWait(this.taskCreationResponse);
}

final class TaskDeletedFail extends TasksState {
  TaskCreationResponse taskCreationResponse;

  TaskDeletedFail(this.taskCreationResponse);
}
