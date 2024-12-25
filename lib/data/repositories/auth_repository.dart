import 'package:tasky_apis/data/models/auth_request.dart';
import 'package:tasky_apis/data/models/auth_response.dart';
import 'package:tasky_apis/data/web_services/auth_web_service.dart';

class AuthRepository {
  final AuthWebService authWebService;

  AuthRepository({required this.authWebService});

  Future<AuthResponse> auth(AuthRequest authRequest) async {
    final json = await authWebService.auth(authRequest);

    final authResponse = AuthResponse.fromJson(json);
    return authResponse;
  }
}
