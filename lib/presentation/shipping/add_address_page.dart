import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/data/models/requests/add_address_request_model.dart';

import '../../common/components/button.dart';
import '../../common/components/custom_dropdown.dart';
import '../../common/components/custom_text_field2.dart';
import '../../common/components/spaces.dart';
import '../../data/datasources/authentication/auth_local_datasource.dart';
import '../../data/models/responses/city_response_model.dart';
import '../../data/models/responses/province_response_model.dart';
import '../../data/models/responses/subdistrict_response_model.dart';
import 'bloc/bloc/add_address_bloc.dart';
import 'bloc/city/city_bloc.dart';
import 'bloc/province/province_bloc.dart';
import 'bloc/subdistrict/subdistrict_bloc.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool isDefault = false;

  Province selectedNewProvince = Province(
    provinceId: '0',
    province: 'Province',
  );

  City selectedNewCity = City(
    cityId: '01',
    provinceId: '-',
    province: 'x',
    type: 'Kab',
    cityName: 'City',
    postalCode: '80351',
  );

  SubDistrict selectedNewSubdistrict = SubDistrict(
    subdistrictId: '011',
    provinceId: '123',
    province: 'w',
    cityId: '13',
    city: 'City Subs',
    type: 'Kabs',
    subdistrictName: 'Subdistrict',
  );

  @override
  void initState() {
    context.read<ProvinceBloc>().add(const ProvinceEvent.getAll());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();

    zipCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Alamat'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: nameController,
            label: 'Nama Lengkap',
            keyboardType: TextInputType.name,
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: addressController,
            label: 'Alamat Jalan',
            maxLines: 3,
            keyboardType: TextInputType.multiline,
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: phoneNumberController,
            label: 'No Handphone',
            keyboardType: TextInputType.phone,
          ),
          const SpaceHeight(24.0),
          BlocBuilder<ProvinceBloc, ProvinceState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (provinces) {
                  if (selectedNewProvince.province.contains("Province")) {
                    selectedNewProvince = provinces.first;
                  }
                  return CustomDropdown<Province>(
                    value: selectedNewProvince,
                    items: provinces,
                    label: 'Provinsi',
                    onChanged: (value) {
                      setState(() {
                        selectedNewProvince = value!;
                        context.read<CityBloc>().add(
                              CityEvent.getAllByProvinceId(
                                selectedNewProvince.provinceId,
                              ),
                            );
                      });
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          BlocBuilder<CityBloc, CityState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: '-',
                    items: const ['-'],
                    label: 'Kota/Kabupaten',
                    onChanged: (value) {},
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (cities) {
                  if (selectedNewCity.cityName.contains("City")) {
                    selectedNewCity = cities.first;
                  }
                  return CustomDropdown<City>(
                    value: selectedNewCity,
                    items: cities,
                    label: 'Kota/Kabupaten',
                    onChanged: (value) {
                      setState(() {
                        selectedNewCity = value!;
                        context.read<SubdistrictBloc>().add(
                              SubdistrictEvent.getAllSubdistrictByCityId(
                                selectedNewCity.cityId,
                              ),
                            );
                      });
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          BlocBuilder<SubdistrictBloc, SubdistrictState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: '-',
                    items: const ['-'],
                    label: 'Kecamatan',
                    onChanged: (value) {},
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (subdistricts) {
                  if (selectedNewSubdistrict.subdistrictName.contains("Sub")) {
                    selectedNewSubdistrict = subdistricts.first;
                  }
                  // selectedSubDistrict = subdistricts.first;

                  return CustomDropdown<SubDistrict>(
                    value: selectedNewSubdistrict,
                    items: subdistricts,
                    label: 'Kecamatan',
                    onChanged: (value) {
                      setState(() {
                        selectedNewSubdistrict = value!;
                      });
                      log(selectedNewSubdistrict.subdistrictName);
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: zipCodeController,
            label: 'Kode Pos',
            keyboardType: TextInputType.number,
          ),
          const SpaceHeight(24.0),
          CheckboxListTile(
            value: isDefault,
            onChanged: (value) {
              setState(() {
                isDefault = value!;
                log("isDefault: $isDefault");
                log(selectedNewSubdistrict.subdistrictName);
              });
            },
            title: const Text('Simpan sebagai alamat utama'),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddAddressBloc, AddAddressState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (response) {
                Navigator.pop(context, response);
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Button.filled(
                  onPressed: () async {
                    //get userID from local storage
                    final userId =
                        (await AuthLocalDatasource().getUserCache()).id;
                    // context.read<AddAddressBloc>().add(
                    //       AddAddressEvent.addAddress(
                    //         name: nameController.text,
                    //         address: addressController.text,
                    //         phone: phoneNumberController.text,
                    //         provinceId: selectedProvince.provinceId,
                    //         cityId: selectedCity.cityId,
                    //         subdistrictId: selectedSubDistrict.subdistrictId,
                    //         provinceName: selectedProvince.province,
                    //         cityName: selectedCity.cityName,
                    //         subdistrictName:
                    //             selectedSubDistrict.subdistrictName,
                    //         codePos: zipCodeController.text,
                    //         userId: userId!.toString(),
                    //         isDefault: isDefault,
                    //       ),
                    //     );
                    log(selectedNewProvince.province);
                    log(selectedNewCity.cityName);
                    log(selectedNewSubdistrict.subdistrictName);
                  },
                  label: 'Tambah Alamat',
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (message) {
                return Button.filled(
                  onPressed: () {},
                  label: 'Error',
                );
              },
            );
          },
        ),
      ),
    );
  }
}
