import 'package:fitness/core/constants/request_status.dart';

class SignupState {
  final bool isPasswordObscured;
  final RequestStatus status;
  final String? errorMessage;

  const SignupState({
    this.isPasswordObscured = true,
    this.status = RequestStatus.initial,
    this.errorMessage,
  });

  SignupState copyWith({
    bool? isPasswordObscured,
    RequestStatus? status,
    String? errorMessage,
  }) {
    return SignupState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}