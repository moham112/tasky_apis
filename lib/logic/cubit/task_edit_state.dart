part of 'task_edit_cubit.dart';

@immutable
sealed class TaskEditState {}

final class TaskEditInitial extends TaskEditState {}

final class TaskEditSuccess extends TaskEditState {}

final class TaskEditFail extends TaskEditState {}
