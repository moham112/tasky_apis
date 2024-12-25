import 'package:tasky_apis/core/constants/network.dart';
import 'package:tasky_apis/core/dio_helper.dart';
import 'package:tasky_apis/data/models/register_request.dart';

class RegisterWebService {
  Future<dynamic> register(RegisterRequest registerRequest) async {
    final response = await DioHelper.postData(
        endPoint: endPoints['register']!, body: registerRequest.toJson());

    return response.data;
  }
}
