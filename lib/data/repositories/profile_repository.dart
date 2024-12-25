// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tasky_apis/data/models/profile_response.dart';
import 'package:tasky_apis/data/web_services/profile_web_service.dart';

class ProfileRepository {
  ProfileWebService profileWebService;

  ProfileRepository({
    required this.profileWebService,
  });

  Future<ProfileResponse> getProfile() async {
    final json = await profileWebService.getProfile();
    final profileResponse = ProfileResponse.fromJson(json);

    return profileResponse;
  }
}
