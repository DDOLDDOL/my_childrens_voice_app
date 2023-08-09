part of 'nursing_home_searching_cubit.dart';

@freezed
class NursingHomeSearchingState with _$NursingHomeSearchingState {
  const factory NursingHomeSearchingState.initial() = _Initial;
  const factory NursingHomeSearchingState.loading() = _Loading;
  const factory NursingHomeSearchingState.loaded(
    List<NursingHomeData> nursingHomes,
  ) = _Loaded;
  const factory NursingHomeSearchingState.error(
    String message,
    String reason,
  ) = _Error;
}
