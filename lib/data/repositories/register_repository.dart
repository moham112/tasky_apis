import 'package:tasky_apis/data/models/register_request.dart';
import 'package:tasky_apis/data/models/register_response.dart';
import 'package:tasky_apis/data/web_services/register_web_service.dart';

class RegisterRepository {
  RegisterWebService registerWebService;
  RegisterRepository({
    required this.registerWebService,
  });

  Future<RegisterResponse> reigster(RegisterRequest registerRequest) async {
    final Map<String, dynamic> registerResponseJSON =
        await registerWebService.register(registerRequest);
    RegisterResponse registerResponse =
        RegisterResponse.fromJson(registerResponseJSON);
    return registerResponse;
  }
}
