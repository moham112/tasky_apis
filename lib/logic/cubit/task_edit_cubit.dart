import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'task_edit_state.dart';

class TaskEditCubit extends Cubit<TaskEditState> {
  TaskEditCubit() : super(TaskEditInitial());
}
