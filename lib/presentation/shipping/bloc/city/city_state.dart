part of 'city_bloc.dart';

@freezed
class CityState with _$CityState {
  const factory CityState.initial() = _Initial;
  const factory CityState.loading() = _Loading;
  const factory CityState.loaded(List<City> listCity) = _Loaded;
  const factory CityState.error(String errorMessage) = _Error;
}
