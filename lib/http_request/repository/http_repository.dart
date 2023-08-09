import 'package:my_childrens_voice_app/api/api.dart';
import 'package:my_childrens_voice_app/common/commons.dart';

class HttpRepository {
  const HttpRepository(this._client);

  final RestApiClient _client;

  Future<void> signUp() async {
    final response = await _client.post(
      '',
      body: {},
    );

    if (response.hasException) throw response.exception!;
  }

  Future<void> registerNursingHome() async {
    final response = await _client.post(
      '',
      body: {

      },
      needAuth: true,
    );

    if (response.hasException) throw response.exception!;
  }

  Future<void> registerInpatient(Inpatient inpatient) async {
    final response = await _client.post(
      '',
      body: inpatient.toJson(),
      needAuth: true,
    );

    if (response.hasException) throw response.exception!;
  }
}
