import 'package:fitness/core/constants/request_status.dart';
import 'package:fitness/core/network/repository.dart';
import 'package:fitness/screens/profile/data/complete_profile_request.dart';
import 'package:fitness/screens/profile/logic/complete_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  final AuthRepository _repository;

  CompleteProfileCubit(this._repository) : super(const CompleteProfileState());

  void selectGender(String gender) {
    // Reset status to initial so listener doesn't trigger the old error
    emit(state.copyWith(selectedGender: gender, status: RequestStatus.initial));
  }

  Future<void> submitProfile({
    required String height,
    required String weight,
    required String age,
  }) async {
    emit(state.copyWith(status: RequestStatus.loading));

    try {
      final doubleHeight = double.tryParse(height) ?? 0.0;
      final doubleWeight = double.tryParse(weight) ?? 0.0;
      final intAge = int.tryParse(age) ?? 0;

      final request = CompleteProfileRequestModel(
        height: doubleHeight,
        weight: doubleWeight,
        age: intAge,
        gender: state.selectedGender,
      );

      await _repository.completeProfile(request);

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