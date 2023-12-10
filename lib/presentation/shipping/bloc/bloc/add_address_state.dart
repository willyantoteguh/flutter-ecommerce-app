part of 'add_address_bloc.dart';

@freezed
class AddAddressState with _$AddAddressState {
  const factory AddAddressState.initial() = _Initial;
  const factory AddAddressState.loading() = _Loading;
  const factory AddAddressState.loaded(AddAddressResponseModel addAddressResponseModel) = _Loaded;
  const factory AddAddressState.error(String errorMessage) = _Error;
}
