import 'package:fitness/core/constants/request_status.dart';

class CompleteProfileState {
  final RequestStatus status;
  final String selectedGender;
  final String? errorMessage;

  const CompleteProfileState({
    this.status = RequestStatus.initial,
    this.selectedGender = 'Male',
    this.errorMessage,
  });

  CompleteProfileState copyWith({
    RequestStatus? status,
    String? selectedGender,
    String? errorMessage,
  }) {
    return CompleteProfileState(
      status: status ?? this.status,
      selectedGender: selectedGender ?? this.selectedGender,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}