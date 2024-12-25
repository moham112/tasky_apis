import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky_apis/data/models/register_request.dart';
import 'package:tasky_apis/data/models/register_response.dart';
import 'package:tasky_apis/data/repositories/register_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this.registerRepository,
  ) : super(RegisterWaiting(registerResponse: RegisterResponse()));

  RegisterRepository registerRepository;
  RegisterResponse? registerResponse;

  static RegisterCubit get(context) => BlocProvider.of(context);

  Future<void> register(RegisterRequest regsiterRequest) async {
    emit(RegisterWaiting(registerResponse: registerResponse));
    await registerRepository.reigster(regsiterRequest).then((value) {
      registerResponse = value;
      emit(RegisterSuccess(registerResponse: registerResponse));
    }).catchError((error) {
      registerResponse = null;
      emit(RegisterFail(registerResponse: registerResponse));
    });
  }
}
