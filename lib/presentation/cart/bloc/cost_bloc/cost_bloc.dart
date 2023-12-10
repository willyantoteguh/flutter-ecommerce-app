import 'package:bloc/bloc.dart';
import '../../../../data/datasources/rajaongkir/rajaongkir_remote_datasource.dart';
import '../../../../data/models/responses/cost_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cost_event.dart';
part 'cost_state.dart';
part 'cost_bloc.freezed.dart';

class CostBloc extends Bloc<CostEvent, CostState> {
  CostBloc() : super(const _Initial()) {
    on<_GetCost>((event, emit) async {
      emit(const _Loading());

      final response = await RajaOngkirRemoteDatasource()
          .getCost(event.origin, event.destination, event.courier);
   
      response.fold(
          (failure) => emit(_Error(failure)), (data) => emit(_Loaded(data)));
    });
  }
}
