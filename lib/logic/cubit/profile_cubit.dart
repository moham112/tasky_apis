import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky_apis/data/models/profile_response.dart';
import 'package:tasky_apis/data/repositories/profile_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepository)
      : super(ProfileInitial(profileResponse: ProfileResponse()));

  ProfileRepository profileRepository;
  ProfileResponse? profileResponse;

  static ProfileCubit get(context) => BlocProvider.of(context);

  void getProfile() {
    emit(ProfileInitial(profileResponse: ProfileResponse()));

    profileRepository.getProfile().then((value) {
      profileResponse = value;
      emit(ProfileLoaded(profileResponse: profileResponse));
    }).catchError((error) {
      profileResponse = null;
      emit(ProfileFail(profileResponse: profileResponse));
    });
  }
}
