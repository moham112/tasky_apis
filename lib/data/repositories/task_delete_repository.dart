import 'package:tasky_apis/data/models/task_creation_response.dart';
import 'package:tasky_apis/data/web_services/task_delete_webservices.dart';

class TaskDeleteRepository {
  TaskDeleteWebservices taskDeleteWebservices;

  TaskDeleteRepository({required this.taskDeleteWebservices});

  Future<TaskCreationResponse> deleteTask(String id) async {
    final json = await taskDeleteWebservices.deleteTask(id);
    TaskCreationResponse taskCreationResponse =
        TaskCreationResponse.fromJson(json);

    return taskCreationResponse;
  }
}
