import 'package:tasky_apis/core/constants/network.dart';
import 'package:tasky_apis/core/dio_helper.dart';

class RefreshTokenWebService {
  Future<dynamic> refreshToken(String refreshToken) async {
    final response = await DioHelper.getData(
      endPoint: endPoints['refresh-token']!,
      queryParams: {"token": refreshToken},
    );
    return response.data;
  }
}
