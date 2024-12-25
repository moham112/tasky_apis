import 'package:tasky_apis/data/models/task_creation_response.dart';
import 'package:tasky_apis/data/models/task_edit_request.dart';
import 'package:tasky_apis/data/web_services/task_edit_webservice.dart';

class TaskEditRepository {
  TaskEditRepository(this.taskEditWebServices);

  TaskCreationResponse? taskCreationResponse;
  TaskEditWebService taskEditWebServices;

  Future<TaskCreationResponse> editTask(TaskEditRequest taskEditRequest) async {
    final json = await taskEditWebServices.editTask(taskEditRequest);
    TaskCreationResponse taskEditResponse = TaskCreationResponse.fromJson(json);

    return taskEditResponse;
  }
}
