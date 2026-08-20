import 'package:dio/dio.dart';
import 'package:fitness/core/constants/api_endpoint.dart';
import 'package:fitness/core/helper/cache_helper.dart';
import 'package:fitness/core/models/base_response.dart';
import 'package:fitness/core/models/user_model.dart';
import 'package:fitness/core/network/dio_factory.dart';
import 'package:fitness/screens/auth/data/login_request.dart';
import 'package:fitness/screens/auth/data/login_response.dart';
import 'package:fitness/screens/profile/data/complete_profile_request.dart';
import 'package:fitness/screens/signup/data/signup_request.dart';

abstract class AuthRepository {
  Future<void> signUp(SignUpRequestModel request);
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<UserModel> completeProfile(CompleteProfileRequestModel request);
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio = DioFactory.getDio();

  @override
  Future<void> signUp(SignUpRequestModel request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.signUp,
        data: request.toJson(),
      );

      final baseResponse = BaseResponse<void>.fromJson(response.data, null);

      if (!baseResponse.isSuccess) {
        throw Exception(
          baseResponse.message.isNotEmpty
              ? baseResponse.message
              : 'Signup failed',
        );
      }
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );

      final baseResponse = BaseResponse<LoginResponseModel>.fromJson(
        response.data,
            (json) => LoginResponseModel.fromJson(json as Map<String, dynamic>),
      );

      if (!baseResponse.isSuccess || baseResponse.data == null) {
        throw Exception(
          baseResponse.message.isNotEmpty
              ? baseResponse.message
              : 'Login failed',
        );
      }

      final loginData = baseResponse.data!;

      await CacheHelper.saveAuthData(
        token: loginData.token,
        userId: loginData.user.id,
        userName: loginData.user.name,
        userEmail: loginData.user.email,
        userType: loginData.user.userType,
      );

      return loginData;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  @override
  Future<UserModel> completeProfile(CompleteProfileRequestModel request) async {
    try {
      final token = await CacheHelper.getToken();

      final response = await _dio.put(
        ApiEndpoints.updateProfile,
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
          },
        ),
      );

      final baseResponse = BaseResponse<UserModel>.fromJson(
        response.data,
            (json) => UserModel.fromJson(json as Map<String, dynamic>),
      );

      if (!baseResponse.isSuccess || baseResponse.data == null) {
        throw Exception(
          baseResponse.message.isNotEmpty
              ? baseResponse.message
              : 'Failed to complete profile',
        );
      }

      return baseResponse.data!;
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null) {
      final responseData = e.response?.data;
      if (responseData is Map<String, dynamic>) {
        return responseData['message'] ?? 'Network error occurred';
      } else if (responseData is String && responseData.isNotEmpty) {
        return responseData;
      }
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionError) {
      return 'Cannot connect to server. Check your connection or backend status.';
    }
    return 'An unexpected error occurred. Please try again.';
  }
}