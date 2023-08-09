import 'package:dio/dio.dart';
import 'package:my_childrens_voice_app/api/api.dart';
import 'package:my_childrens_voice_app/home/models/models.dart';

import '../../common/commons.dart';

class HomeRepository {
  const HomeRepository(this._client);

  final RestApiClient _client;

  Future<List<NursingHomeData>> searchNursingHome(String keyword) async {
    final response = await _client.searchNaver(keyword);

    if (response.hasException) throw response.exception!;

    return (response.data['items'] as List).map((json) {
      final name = removeHtmlTags(json['title']);
      final address = removeHtmlTags(json['roadAddress']);

      return NursingHomeData(name, address);
    }).toList();
  }
}
