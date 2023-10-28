import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../common/constants/variables.dart';
import '../../models/responses/product_response_model.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getAllProduct() async {
    final response = await http
        .get(Uri.parse('${Variables.baseUrl}/api/products?populate=*'));
    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}
