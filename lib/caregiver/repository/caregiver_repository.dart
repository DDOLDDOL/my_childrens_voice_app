import 'package:my_childrens_voice_app/api/api.dart';
import 'package:my_childrens_voice_app/common/commons.dart';

class CaregiverRepository {
  const CaregiverRepository(this._client);

  final RestApiClient _client;

  Future<List<Inpatient>> fetchMyInpatients() async {
    // final response = await _client.get(
    //   '',
    //   needAuth: true,
    // );
    //
    // if(response.hasException) throw response.exception!;

    final dynamic response = [
      {
        'id': 1,
        'name': '최엄마',
        'birthDate': '1950-08-07',
        'gender': '여성',
        'personalCode': 'QXf1_454',
        'important': true,
      },
      {
        'id': 2,
        'name': '황아빠',
        'birthDate': '1945-11-20',
        'gender': '남성',
        'personalCode': 'QXf9_222',
        'important': false,
      },
    ];

    return (response as List).map((data) => Inpatient.fromJson(data)).toList();
  }

  Future<List<String>> fetchReceivedMessages() async {
    return [
      '엄마 사랑해. 밥 먹었어?',
      '엄마 사랑해. 밥 먹었어?',
      '엄마 사랑해. 밥 먹었어?',
    ];
  }
}