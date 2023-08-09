part of 'rest_api_client.dart';

@freezed
class RequestType with _$RequestType {
  const factory RequestType.get() = _Get;
  const factory RequestType.post() = _Post;
  const factory RequestType.put() = _Put;
  const factory RequestType.delete() = _Delete;
}
