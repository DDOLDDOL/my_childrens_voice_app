import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_childrens_voice_app/home/home.dart';
import 'package:path_provider/path_provider.dart';

class AudioFileDetectCubit extends Cubit<bool> {
  AudioFileDetectCubit(this._repository) : super(false);

  final HomeRepository _repository;

  Future<void> searchFileByNumber(int fileNumber) async {
    try {
      final isFileExists =
          await _repository.isVoiceTrainingFileExists(fileNumber);
      emit(isFileExists);
    } on Exception {
      emit(false);
    }
  }

  Future<void> deleteFileByNumber(int fileNumber) async {
    final isFileExists = await _repository.deleteVoiceTrainingFile(fileNumber);
    emit(isFileExists);
  }
}
