import 'package:fitness/core/constants/request_status.dart';
import 'package:fitness/core/network/repository.dart';
import 'package:fitness/screens/auth/data/login_request.dart';
import 'package:fitness/screens/auth/logic/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginState());

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: RequestStatus.loading));

    try {
      final request = LoginRequestModel(
        email: email,
        password: password,
      );

      // Repository executes API call & automatically saves user data to CacheHelper
      await _authRepository.login(request);

      emit(state.copyWith(status: RequestStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }
}