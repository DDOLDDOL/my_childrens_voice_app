part of 'my_inpatient_cubit.dart';

@freezed
class MyInpatientState with _$MyInpatientState {
  const factory MyInpatientState.initial() = _Initial;
  const factory MyInpatientState.loading() = _Loading;
  const factory MyInpatientState.loaded(List<Inpatient> inpatients) = _Loaded;
  const factory MyInpatientState.error(String message, String reason) = _Error;
}