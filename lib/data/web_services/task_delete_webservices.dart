import 'package:tasky_apis/core/constants/network.dart';
import 'package:tasky_apis/core/dio_helper.dart';

class TaskDeleteWebservices {
  Future<dynamic> deleteTask(String id) async {
    final response =
        await DioHelper.deleteData(endPoint: "${endPoints['tasks']}/$id");
    return response.data;
  }
}
