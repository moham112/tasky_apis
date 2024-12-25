import 'package:tasky_apis/core/constants/network.dart';
import 'package:tasky_apis/core/dio_helper.dart';
import 'package:tasky_apis/data/models/auth_request.dart';

class AuthWebService {
  Future<dynamic> auth(AuthRequest authRequest) async {
    final authResponse = await DioHelper.postData(
        endPoint: endPoints['login']!, body: authRequest.toJson());
    return authResponse.data;
  }
}
