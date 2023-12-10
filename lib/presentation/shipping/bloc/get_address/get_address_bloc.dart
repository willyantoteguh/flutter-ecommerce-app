import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/order/order_remote_datasource.dart';
import '../../../../data/models/responses/get_address_response_model.dart';

part 'get_address_bloc.freezed.dart';
part 'get_address_event.dart';
part 'get_address_state.dart';

class GetAddressBloc extends Bloc<GetAddressEvent, GetAddressState> {
  GetAddressBloc() : super(const _Initial()) {
    on<_GetAddress>((event, emit) async {
      emit(const _Loading());
      
      final response = await OrderRemoteDatasource().getAddressByUserId();

      response.fold(
          (failure) => emit(_Error(failure)), (data) => emit(_Loaded(data)));
    });
  }
}
