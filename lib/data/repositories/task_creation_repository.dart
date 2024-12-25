import 'package:tasky_apis/data/models/task_creation_request.dart';
import 'package:tasky_apis/data/models/task_creation_response.dart';
import 'package:tasky_apis/data/web_services/task_creation_web_services.dart';

class TaskCreationRepository {
  TaskCreationWebServices taskCreationWebServices;
  TaskCreationResponse? taskCreationResponse;

  TaskCreationRepository(this.taskCreationWebServices);

  Future<TaskCreationResponse> createTask(
      TaskCreationRequest taskCreationRequest) async {
    final json = await taskCreationWebServices.createTask(taskCreationRequest);
    TaskCreationResponse taskCreationResponse =
        TaskCreationResponse.fromJson(json);

    return taskCreationResponse;
  }
}
