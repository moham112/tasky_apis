part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {
  final RegisterResponse? registerResponse;

  RegisterInitial({required this.registerResponse});
}

class RegisterWaiting extends RegisterState {
  final RegisterResponse? registerResponse;

  RegisterWaiting({required this.registerResponse});
}

class RegisterSuccess extends RegisterState {
  final RegisterResponse? registerResponse;

  RegisterSuccess({required this.registerResponse});
}

class RegisterFail extends RegisterState {
  final RegisterResponse? registerResponse;

  RegisterFail({required this.registerResponse});
}
