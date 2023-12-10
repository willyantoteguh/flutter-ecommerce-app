part of 'province_bloc.dart';

@freezed
class ProvinceState with _$ProvinceState {
  const factory ProvinceState.initial() = _Initial;
  const factory ProvinceState.loading() = _Loading;
  const factory ProvinceState.loaded(List<Province> listProvinces) = _Loaded;
  const factory ProvinceState.error(String errorMessage) = _Error;
}
