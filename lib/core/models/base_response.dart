class BaseResponse<T> {
  final String result;
  final String message;
  final T? data;

  BaseResponse({
    required this.result,
    required this.message,
    this.data,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json)? fromJsonT,
      ) {
    return BaseResponse<T>(
      result: json['result'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
    );
  }

  bool get isSuccess => result.toLowerCase() == 'success';
}