part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {
  ProfileResponse? profileResponse;

  ProfileInitial({required this.profileResponse});
}

final class ProfileLoaded extends ProfileState {
  ProfileResponse? profileResponse;

  ProfileLoaded({required this.profileResponse});
}

final class ProfileFail extends ProfileState {
  ProfileResponse? profileResponse;

  ProfileFail({required this.profileResponse});
}
