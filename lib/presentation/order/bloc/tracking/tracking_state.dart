part of 'tracking_bloc.dart';

@freezed
class TrackingState with _$TrackingState {
  const factory TrackingState.initial() = _Initial;
  const factory TrackingState.loading() = _Loading;
  const factory TrackingState.loaded(WaybillSuccessResponseModel data) = _Loaded;
  const factory TrackingState.error(WaybillFailedResponseModel failed) = _Error;
}
