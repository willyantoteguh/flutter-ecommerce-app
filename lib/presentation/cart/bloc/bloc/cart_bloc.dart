import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../widgets/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const _Loaded([])) {
    on<_Add>((event, emit) {
      final currentState = state as _Loaded;

      final indexById = currentState.listOfCart
          .indexWhere((item) => item.product.id == event.cart.product.id);

      if (indexById >= 0) {
        currentState.listOfCart[indexById].quantity += 1;
        emit(const _Loading());
        emit(_Loaded(currentState.listOfCart));
      } else {
        emit(_Loaded([...currentState.listOfCart, event.cart]));
      }
    });

    on<_Remove>((event, emit) {
      final currentState = state as _Loaded;

      final indexById = currentState.listOfCart
          .indexWhere((item) => item.product.id == event.cart.product.id);

      if (indexById >= 0) {
        currentState.listOfCart[indexById].quantity -= 1;

        if (currentState.listOfCart[indexById].quantity <= 0) {
          currentState.listOfCart.removeAt(indexById);
        }
        emit(const _Loading());
        emit(_Loaded(currentState.listOfCart));
      }
    });
  }
}
