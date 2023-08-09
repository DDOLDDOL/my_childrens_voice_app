part of 'rest_api_client.dart';

extension ResponseExtension on Response {
  Response get toJsonDecoded {
    /// String or null will be returned when status code is 500
    if (statusCode == 500) return this;

    /// Returned with simple string
    if (data is String) return this;

    /// return Response with [List<Json>] decoded data field if data's type is list
    if (data is List) {
      data = (data as List).cast<Json>().toList();
      return this;
    }

    /// return Response with [Json] decoded data field if data's type is not list
    data = data as Json;
    return this;
  }

  ApiException? get exception {
    /// request success
    if ((statusCode! / 100).floor() == 2) return null;

    /// internal server exception
    if (statusCode == 500) return const ApiException.serverError();

    /// unauthorized exception
    if (statusCode == 401) return const ApiException.unauthorizedError();

    /// api common exception
    return ApiException.apiError(statusCode!, message: data['message']);
  }

  bool get hasException => exception != null;
}
