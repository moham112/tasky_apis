import 'package:tasky_apis/core/constants/network.dart';
import 'package:tasky_apis/data/models/task_edit_request.dart';
import 'package:tasky_apis/core/dio_helper.dart';

class TaskEditWebService {
  Future<dynamic> editTask(TaskEditRequest taskEditRequest) async {
    final response = await DioHelper.putData(
      endPoint: "${endPoints['tasks']}/${taskEditRequest.id}",
      body: taskEditRequest.toJson(),
    );
    return response.data;
  }
}
