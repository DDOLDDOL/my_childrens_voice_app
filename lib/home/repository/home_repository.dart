import 'dart:developer';

import 'package:my_childrens_voice_app/api/api.dart';
import 'package:my_childrens_voice_app/home/models/models.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<bool> isVoiceTrainingFileExists(int fileNumber) async {
    final cacheDir = await getApplicationCacheDirectory();

    log('the file name is ${cacheDir.uri}voice_training_$fileNumber');

    final target = cacheDir.listSync().where((file) {
      return file.uri.toString().split('voice_training_').lastOrNull ==
          fileNumber.toString();
    }).lastOrNull;

    return target != null;
  }

  Future<bool> deleteVoiceTrainingFile(int fileNumber) async {
    final cacheDir = await getApplicationCacheDirectory();

    final target = cacheDir.listSync().where((file) {
      return file.uri.toString().split('voice_training_').lastOrNull ==
          fileNumber.toString();
    }).lastOrNull;

    try {
      await target?.delete();
    } on Exception catch (error) {
      log('file delete error: $error');
    }

    return await isVoiceTrainingFileExists(fileNumber);
  }
}
