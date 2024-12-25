import 'package:tasky_apis/data/models/task_creation_response.dart';
import 'package:tasky_apis/data/web_services/tasks_webservice.dart';

class TasksRepository {
  TasksWebservice tasksWebservice;
  TasksRepository({
    required this.tasksWebservice,
  });
  Future<List<TaskCreationResponse>> getTasks() async {
    final json = await tasksWebservice.getTasks();
    List<TaskCreationResponse> tasksCreationsResponse =
        json.map((task) => TaskCreationResponse.fromJson(task)).toList();

    return tasksCreationsResponse;
  }
}
