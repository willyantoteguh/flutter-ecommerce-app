import 'package:flutter_ecommerce_app/common/constants/variables.dart';
import 'package:flutter_ecommerce_app/data/models/responses/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(AuthResponseModel model) async {
    final sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.setString(Variables.authKey, model.toJson());
  }

  Future<void> removeAuthData() async {
    final sharedPreference = await SharedPreferences.getInstance();
    await sharedPreference.remove(Variables.authKey);
  }

  Future<String> getCacheToken() async {
    final sharedPreference = await SharedPreferences.getInstance();
    final authJson = sharedPreference.getString(Variables.authKey) ?? "";
    final authData = AuthResponseModel.fromJson(authJson);
    return authData.jwt ?? "";
  }

  Future<User> getUserCache() async {
    final sharedPreference = await SharedPreferences.getInstance();
    final authJson = sharedPreference.getString(Variables.authKey) ?? "";
    final authData = AuthResponseModel.fromJson(authJson);
    return authData.user!;
  }

  Future<bool> isLogin() async {
    final sharedPreference = await SharedPreferences.getInstance();
    final authJson = sharedPreference.getString(Variables.authKey) ?? "";
    return authJson.isNotEmpty;
  }
}
