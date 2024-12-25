import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tasky_apis/data/models/auth_request.dart';
import 'package:tasky_apis/data/models/auth_response.dart';
import 'package:tasky_apis/data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial());

  final AuthRepository authRepository;
  AuthResponse? authResponse;

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> auth(AuthRequest authRequest) async {
    emit(AuthInitial());

    await authRepository.auth(authRequest).then((value) {
      authResponse = value;

      // if(authResponse!.refreshToken == null) {

      // }

      emit(AuthSuccess());
    }).catchError((error) {
      authResponse = null;
      emit(AuthFail());
    });
  }
}
