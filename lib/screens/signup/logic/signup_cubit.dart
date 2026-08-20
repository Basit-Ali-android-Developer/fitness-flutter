import 'package:fitness/core/constants/request_status.dart';
import 'package:fitness/core/network/repository.dart';
import 'package:fitness/screens/signup/data/signup_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_state.dart';


class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit(this._authRepository) : super(const SignupState());

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: RequestStatus.loading));

    try {
      final request = SignUpRequestModel(
        name: name,
        email: email,
        password: password,
      );

      await _authRepository.signUp(request);

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