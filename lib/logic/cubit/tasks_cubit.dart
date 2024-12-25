import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky_apis/data/models/task_creation_response.dart';
import 'package:tasky_apis/data/models/task_edit_request.dart';
import 'package:tasky_apis/data/repositories/task_delete_repository.dart';
import 'package:tasky_apis/data/repositories/task_edit_repository.dart';
import 'package:tasky_apis/data/repositories/tasks_repository.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksRepository tasksRepository;
  TaskEditRepository taskEditRepository;
  TaskDeleteRepository taskDeleteRepository;

  List<TaskCreationResponse>? taskCreationRepsonses;
  TaskCreationResponse? taskCreationResponse;

  List<TaskCreationResponse>? waiting;
  List<TaskCreationResponse>? inProgress;
  List<TaskCreationResponse>? finished;

  TasksCubit(
      this.tasksRepository, this.taskEditRepository, this.taskDeleteRepository)
      : super(TasksInitial());

  void getTasks() async {
    emit(TasksInitial());
    await tasksRepository.getTasks().then(
      (value) {
        if (value.isEmpty) {
          emit(TasksEmpty());
          taskCreationRepsonses = value;
          waiting = [];
          inProgress = [];
          finished = [];
        } else {
          taskCreationRepsonses = value;

          waiting = taskCreationRepsonses!
              .where((task) => task.status == 'waiting')
              .toList();
          inProgress = taskCreationRepsonses!
              .where((task) => task.status == 'inProgress')
              .toList();
          finished = taskCreationRepsonses!
              .where((task) => task.status == 'finished')
              .toList();

          emit(TasksLoaded(taskCreationRepsonses!));
        }
      },
    ).catchError(
      (error) {
        emit(TasksFail(taskCreationRepsonses!));
      },
    );
  }

  void editTask(TaskEditRequest taskCreationRequest) async {
    emit(TaskEditedWait());
    await taskEditRepository.editTask(taskCreationRequest).then(
      (value) {
        taskCreationResponse = value;
        emit(TaskEditedSuccess(value));
      },
    ).catchError(
      (error) {
        taskCreationResponse = null;
        emit(TaskEditedFail(taskCreationResponse!));
      },
    );
  }

  void deleteTask() async {
    emit(TaskDeletedWait(TaskCreationResponse()));
    await taskDeleteRepository.deleteTask(taskCreationResponse!.sId!).then(
      (value) {
        taskCreationResponse = value;
        emit(TaskDeletedSuccess(value));
      },
    ).catchError(
      (error) {
        taskCreationResponse = null;
        emit(TaskDeletedFail(taskCreationResponse!));
      },
    );
  }
}
