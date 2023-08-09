import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_exception.freezed.dart';

@freezed
class ApiException with _$ApiException implements Exception {
  const factory ApiException.apiError(
    int statusCode, {
    @Default('알 수 없는 에러 발생') String message,
  }) = _ApiError;
  const factory ApiException.unauthorizedError() = _UnauthorizedError;
  const factory ApiException.serverError() = _ServerError;
}