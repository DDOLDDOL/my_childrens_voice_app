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
        'gender': 'Woman',
        'personalCode': 'QXf1_454',
        'important': true,
      },
      {
        'id': 2,
        'name': '황아빠',
        'birthDate': '1945-11-20',
        'gender': 'Man',
        'personalCode': 'QXf9_222',
        'important': false,
      },
    ];

    return (response as List).map((data) => Inpatient.fromJson(data)).toList();
  }
}