import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_childrens_voice_app/guardian/repository/guardian_respository.dart';

part 'sentence_state.dart';
part 'sentence_cubit.freezed.dart';

class SentenceCubit extends Cubit<SentenceState> {
  SentenceCubit(this._repository) : super(const SentenceState());

  final GuardianRepository _repository;

  void next() {
    emit(state.copyWith(index: state.index == 9 ? 45 : state.index + 1));
  }

  void previous() => emit(state.copyWith(index: state.index - 1));

  void getRecordingSentenceList() {
    final sentences = _repository.getRecordingSentenceList();
    emit(state.copyWith(sentences: sentences));
  }
}
