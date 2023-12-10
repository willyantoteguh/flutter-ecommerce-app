import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/order/order_remote_datasource.dart';
import '../../../../data/models/responses/buyer_order_response_model.dart';

part 'buyer_order_bloc.freezed.dart';
part 'buyer_order_event.dart';
part 'buyer_order_state.dart';

class BuyerOrderBloc extends Bloc<BuyerOrderEvent, BuyerOrderState> {
  BuyerOrderBloc() : super(const _Initial()) {
    on<_GetBuyerOrder>((event, emit) async {
      emit(const _Loading());

      final response = await OrderRemoteDatasource().getOrderByBuyerId();
      response.fold(
          (failure) => emit(_Error(failure)), (data) => emit(_Loaded(data.data)));
    });
  }
}
