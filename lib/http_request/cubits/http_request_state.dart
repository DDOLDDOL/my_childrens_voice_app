part of 'http_request_cubit.dart';

@freezed
class HttpRequestState with _$HttpRequestState {
  const factory HttpRequestState.initial() = _Initial;
  const factory HttpRequestState.loading() = _Loading;
  const factory HttpRequestState.success() = _Success;
  const factory HttpRequestState.error(String message, String reason) = _Error;
}
