import 'dart:convert';

class AddAddressRequestModel {
  final Address data;

  AddAddressRequestModel({
    required this.data,
  });

  factory AddAddressRequestModel.fromJson(String str) =>
      AddAddressRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddAddressRequestModel.fromMap(Map<String, dynamic> json) =>
      AddAddressRequestModel(
        data: Address.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class Address {
  final String name;
  final String address;
  final String phone;
  final String provId;
  final String cityId;
  final String subdistrictId;
  final String codePos;
  final String userId;
  final bool isDefault;

  Address({
    required this.name,
    required this.address,
    required this.phone,
    required this.provId,
    required this.cityId,
    required this.subdistrictId,
    required this.codePos,
    required this.userId,
    required this.isDefault,
  });

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        provId: json["prov_id"],
        cityId: json["city_id"],
        subdistrictId: json["subdistrict_id"],
        codePos: json["code_pos"],
        userId: json["user_id"],
        isDefault: json["is_default"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "address": address,
        "phone": phone,
        "prov_id": provId,
        "city_id": cityId,
        "subdistrict_id": subdistrictId,
        "code_pos": codePos,
        "user_id": userId,
        "is_default": isDefault,
      };
}
