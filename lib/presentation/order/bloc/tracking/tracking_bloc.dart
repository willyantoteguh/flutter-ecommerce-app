import 'package:bloc/bloc.dart';
import '../../../../data/datasources/rajaongkir/rajaongkir_remote_datasource.dart';
import '../../../../data/models/responses/waybill_failed_response_model.dart';
import '../../../../data/models/responses/waybill_success_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tracking_event.dart';
part 'tracking_state.dart';
part 'tracking_bloc.freezed.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  TrackingBloc() : super(const _Initial()) {
    on<_GetTracking>((event, emit) async {
      emit(const _Loading());

      final response = await RajaOngkirRemoteDatasource()
          .getWayBill(event.resi, event.courier);

      response.fold(
          (failure) => emit(_Error(failure)), (data) => emit(_Loaded(data)));
    });
  }
}
