import 'package:bloc/bloc.dart';
import '../../../../data/datasources/rajaongkir/rajaongkir_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/responses/subdistrict_response_model.dart';

part 'subdistrict_event.dart';
part 'subdistrict_state.dart';
part 'subdistrict_bloc.freezed.dart';

class SubdistrictBloc extends Bloc<SubdistrictEvent, SubdistrictState> {
  SubdistrictBloc() : super(const _Initial()) {
    on<_GetAllSubdistrictByCityId>((event, emit) async {
      emit(const _Loading());

      final response = await RajaOngkirRemoteDatasource().getSubDistrict(event.city);
      return response.fold(
        (failure) => emit(_Error(failure)),
        (data) => emit(_Loaded(data.rajaongkir.results)),
      );
    });
  }
}
