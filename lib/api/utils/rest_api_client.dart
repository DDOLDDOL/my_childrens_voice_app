import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/hives/token_hive.dart';
import '../models/models.dart';
import 'classes.dart';
import 'constants.dart';

part 'request_type.dart';

part 'response_extension.dart';

part 'rest_api_client.freezed.dart';

class RestApiClient {
  RestApiClient(this._apiUrl, this._tokenHive);

  final String _apiUrl;
  final TokenHive _tokenHive;
  final _dio = Dio();

  Future<Response> searchNaver(
    String keyword, {
    int display = 5,
    int start = 1,
    String sortString = 'random',
  }) async {
    return get(
      '?query=$keyword&display=$display&start=$start&sort=$sortString',
      apiUrl: naverLocationSearchApiUrl,
      options: Options(
        headers: {
          "X-Naver-Client-Id": naverCliendId,
          "X-Naver-Client-Secret": naverCliendSecret,
        },
      ),
      needAuth: false,
    );
  }

  Future<Response> get(
    String path, {
    bool needAuth = false,
    String? apiUrl,
    Json? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(
      '${apiUrl ?? _apiUrl}$path',
      type: const RequestType.get(),
      needAuth: needAuth,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response> post(
    String path, {
    bool needAuth = false,
    String? apiUrl,
    Json? queryParameters,
    Options? options,
    Json? body,
    CancelToken? cancelToken,
  }) {
    return _request(
      '${apiUrl ?? _apiUrl}$path',
      type: const RequestType.post(),
      needAuth: needAuth,
      queryParameters: queryParameters,
      options: options,
      body: body,
      cancelToken: cancelToken,
    );
  }

  Future<Response> put(
    String path, {
    bool needAuth = false,
    String? apiUrl,
    Json? queryParameters,
    Options? options,
    Json? body,
    CancelToken? cancelToken,
  }) {
    return _request(
      '${apiUrl ?? _apiUrl}$path',
      type: const RequestType.put(),
      needAuth: needAuth,
      queryParameters: queryParameters,
      options: options,
      body: body,
      cancelToken: cancelToken,
    );
  }

  Future<Response> delete(
    String path, {
    bool needAuth = false,
    String? apiUrl,
    Json? queryParameters,
    Options? options,
    Json? body,
    CancelToken? cancelToken,
  }) {
    return _request(
      '${apiUrl ?? _apiUrl}$path',
      type: const RequestType.delete(),
      needAuth: needAuth,
      queryParameters: queryParameters,
      options: options,
      body: body,
      cancelToken: cancelToken,
    );
  }

  Future<Response> _request(
    String path, {
    required RequestType type,
    required bool needAuth,
    Json? queryParameters,
    Options? options,
    Json? body,
    CancelToken? cancelToken,
  }) async {
    /// [method] field in [options] argument must be null because
    /// it is replaced with String value from [type] argument
    assert(options?.method == null);

    final method = type.when(
      get: () => 'GET',
      post: () => 'POST',
      put: () => 'PUT',
      delete: () => 'DELETE',
    );

    final response = await _auth(
      request: () => _dio.request(
        path,
        options: _defaultOptions(options, method: method, needAuth: needAuth),
        data: body,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );

    return ResponseExtension(response).toJsonDecoded;
  }

  Options _defaultOptions(
    Options? options, {
    required String method,
    required bool needAuth,
  }) {
    options ??= Options(headers: {'Content-Type': 'application/json'});
    options.headers ??= {'Content-Type': 'application/json'};
    options.headers!['Content-Type'] ??= 'application/json';

    log('access token: ${_tokenHive.accessToken}');
    log('refresh token: ${_tokenHive.refreshTokenId}');

    if (needAuth) {
      options.headers!.addAll({
        'Authorization': 'Bearer ${_tokenHive.accessToken}',
      });
    }

    return options.copyWith(method: method, validateStatus: (_) => true);
  }

  Future<void> _refreshTokens() async {
    final response = await post(
      '/api/token/refresh/',
      body: {
        'refresh_token_index_id': _tokenHive.refreshTokenId,
      },
    );

    if (response.hasException) return;

    await _tokenHive.setTokens(
      response.data['jwt_token']['access_token'],
      response.data['jwt_token']['refresh_token_index_id'],
    );
  }

  Future<Response> _auth({
    required Future<Response> Function() request,
  }) async {
    final response = await request();

    /// 401 error 발생시에만 _refreshTokens 호출 후 재요청 결과 반환
    if (response.statusCode == 401) {
      await _refreshTokens();

      /// tokens refresh 에러 발생 -> return -> 재 요청 시 똑같이 401 에러 반환
      return await request();
    }

    return response;
  }
}
