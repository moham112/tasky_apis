import 'package:tasky_apis/core/constants/network.dart';
import 'package:tasky_apis/core/dio_helper.dart';

class TasksWebservice {
  Future<List<dynamic>> getTasks() async {
    final response = await DioHelper.getData(endPoint: endPoints['tasks']!);

    if (response.data == null || response.statusCode != 200) {
      throw Exception('Failed to load tasks');
    }

    return response.data;
  }
}
