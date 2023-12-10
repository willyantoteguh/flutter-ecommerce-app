import 'package:bloc/bloc.dart';
import '../../../../data/datasources/order/order_remote_datasource.dart';
import '../../../../data/models/requests/add_address_request_model.dart';
import '../../../../data/models/responses/add_address_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';
part 'add_address_bloc.freezed.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddAddressBloc() : super(const _Initial()) {
    on<_AddAddress>((event, emit) async {
      emit(const _Loading());

      final response = await OrderRemoteDatasource().addAddress(
        AddAddressRequestModel(
            data: Address(
          name: event.name,
          address:
              '${event.address}, ${event.subdistrictName}, ${event.cityName}, ${event.provinceName}, ${event.codePos}',
          phone: event.phone,
          provId: event.provinceId,
          cityId: event.cityId,
          subdistrictId: event.subdistrictId,
          codePos: event.codePos,
          userId: event.userId,
          isDefault: event.isDefault,
        )),
      );

      response.fold(
          (failure) => emit(_Error(failure)), (data) => emit(_Loaded(data)));
    });
  }
}
