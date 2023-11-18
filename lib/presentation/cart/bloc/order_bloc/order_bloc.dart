import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_app/data/datasources/order/order_remote_datasource.dart';
import 'package:flutter_ecommerce_app/data/models/requests/order_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/responses/order_response_model.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Initial()) {
    on<_Order>((event, emit) async {
      emit(const _Loading());
      final response =
          await OrderRemoteDatasource().createOrder(event.orderRequestModel);
      response.fold(
          (failure) => emit(_Error(failure)), (data) => emit(_Success(data)));
    });
  }
}
