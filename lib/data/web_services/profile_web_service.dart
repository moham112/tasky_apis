import 'package:tasky_apis/core/constants/network.dart';
import 'package:tasky_apis/core/dio_helper.dart';

class ProfileWebService {
  Future<dynamic> getProfile() async {
    final response = await DioHelper.getData(endPoint: endPoints['profile']!);

    return response.data;
  }
}
