import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/rajaongkir/rajaongkir_remote_datasource.dart';
import '../../../../data/models/responses/city_response_model.dart';

part 'city_bloc.freezed.dart';
part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(const _Initial()) {
    on<_GetAllCityByProvinceId>((event, emit) async {
      emit(const _Loading());

      final response =
          await RajaOngkirRemoteDatasource().getCity(event.idProvince);
      response.fold(
        (failure) => emit(_Error(failure)),
        (data) => emit(_Loaded(data.rajaongkir.results)),
      );
    });
  }
}
