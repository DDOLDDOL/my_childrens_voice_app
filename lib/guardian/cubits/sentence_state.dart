part of 'sentence_cubit.dart';

@freezed
class SentenceState with _$SentenceState {
  const factory SentenceState({
    @Default([]) List<String> sentences,
    @Default(0) int index,
  }) = _SentenceState;

  const SentenceState._();

  String get currentSentence => sentences[index];
  bool get emptySentences => sentences.isEmpty;
  bool get isFirst => index <= 0;
  bool get isLast => sentences.length - 1 <= index;
}
