import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../common/constants/variables.dart';
import '../../models/responses/city_response_model.dart';
import '../../models/responses/cost_response_model.dart';
import '../../models/responses/province_response_model.dart';
import '../../models/responses/subdistrict_response_model.dart';
import '../../models/responses/waybill_failed_response_model.dart';
import '../../models/responses/waybill_success_response_model.dart';

class RajaOngkirRemoteDatasource {
  Map<String, String> headers = {
    'key': Variables.rajaOngkirKey,
  };

  Future<Either<String, ProvinceResponseModel>> getProvinces() async {
    final urlProvince = Uri.parse('${Variables.rajaOngkirBaseUrl}province');
    final response = await http.get(urlProvince, headers: headers);
    if (response.statusCode == 200) {
      return right(ProvinceResponseModel.fromJson(response.body));
    } else {
      return left('Failure');
    }
  }

  Future<Either<String, CityResponseModel>> getCity(String idProvince) async {
    final urlCity =
        Uri.parse('${Variables.rajaOngkirBaseUrl}city?province=$idProvince');
    final response = await http.get(urlCity, headers: headers);
    if (response.statusCode == 200) {
      return right(CityResponseModel.fromJson(response.body));
    } else {
      return left('Failure');
    }
  }

  Future<Either<String, SubDistrictResponseModel>> getSubDistrict(
      String cityId) async {
    final urlSubDistrict =
        Uri.parse('${Variables.rajaOngkirBaseUrl}subdistrict?city=$cityId');
    final response = await http.get(
      urlSubDistrict,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return right(SubDistrictResponseModel.fromJson(response.body));
    } else {
      return left('Failure');
    }
  }

  Future<Either<String, CostResponseModel>> getCost(
    String origin,
    String destination,
    String courier,
  ) async {
    final url = Uri.parse('${Variables.rajaOngkirBaseUrl}cost');
    final response = await http.post(
      url,
      headers: {
        'key': Variables.rajaOngkirKey,
        'content-type': 'application/x-www-form-urlencoded',
      },
      body: {
        'origin': origin,
        'originType': 'subdistrict',
        'destination': destination,
        'destinationType': 'subdistrict',
        'weight': '500',
        'courier': courier,
      },
    );
    if (response.statusCode == 200) {
      return right(CostResponseModel.fromJson(response.body));
    } else {
      return left('Failure');
    }
  }

  
  Future<Either<WaybillFailedResponseModel, WaybillSuccessResponseModel>>
      getWayBill(
    String waybill,
    String courier,
  ) async {
    final url = Uri.parse('https://pro.rajaongkir.com/api/waybill');
    final response = await http.post(
      url,
      headers: {
        'key': Variables.rajaOngkirKey,
        'content-type': 'application/x-www-form-urlencoded',
      },
      body: {
        'waybill': waybill,
        'courier': courier,
      },
    );
    if (response.statusCode == 200) {
      return right(WaybillSuccessResponseModel.fromJson(response.body));
    } else {
      return left(WaybillFailedResponseModel.fromJson(response.body));
    }
  }

}
