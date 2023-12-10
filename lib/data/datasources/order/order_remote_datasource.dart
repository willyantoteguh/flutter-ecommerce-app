import 'package:dartz/dartz.dart';
import '../../../common/constants/variables.dart';
import '../../models/responses/buyer_order_response_model.dart';
import '../authentication/auth_local_datasource.dart';
import 'package:http/http.dart' as http;

import '../../models/requests/add_address_request_model.dart';
import '../../models/requests/order_request_model.dart';
import '../../models/responses/add_address_response_model.dart';
import '../../models/responses/get_address_response_model.dart';
import '../../models/responses/order_detail_response_model.dart';
import '../../models/responses/order_response_model.dart';

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> createOrder(
      OrderRequestModel orderRequestModel) async {
    final tokenKey = await AuthLocalDatasource().getCacheToken();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $tokenKey',
      },
      body: orderRequestModel.toJson(),
    );

    if (response.statusCode == 200) {
      return right(OrderResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, OrderDetailResponseModel>> getOrderById(
      String id) async {
    final token = await AuthLocalDatasource().getCacheToken();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/orders/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return right(OrderDetailResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, AddAddressResponseModel>> addAddress(
      AddAddressRequestModel request) async {
    final token = await AuthLocalDatasource().getCacheToken();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/addresses'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return right(AddAddressResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }

  Future<Either<String, GetAddressResponseModel>> getAddressByUserId() async {
    final token = await AuthLocalDatasource().getCacheToken();
    final user = await AuthLocalDatasource().getUserCache();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/addresses?filters[user_id][\$eq]=${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return right(GetAddressResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }

  Future<Either<String, BuyerOrderResponseModel>> getOrderByBuyerId() async {
    final token = await AuthLocalDatasource().getCacheToken();
    final user = await AuthLocalDatasource().getUserCache();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/orders?filters[buyerId][\$eq]=${user.id}}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return right(BuyerOrderResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }
}
