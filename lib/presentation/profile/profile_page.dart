import 'package:flutter/material.dart';

import '../../common/constants/colors.dart';
import '../../common/constants/images.dart';
import '../../data/datasources/authentication/auth_local_datasource.dart';
import '../authentication/login_page.dart';
import '../order/order_page.dart';
import '../shipping/shipping_address_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Image.asset(
              Images.iconUser,
              width: 24.0,
            ),
            title: const Text(
              'Profil',
              style: TextStyle(
                color: ColorName.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const ProfilePage()),
              // );
            },
          ),
          ListTile(
            leading: Image.asset(
              Images.iconBag,
              width: 24.0,
            ),
            title: const Text(
              'Pesanan',
              style: TextStyle(
                color: ColorName.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderPage()),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              Images.iconLocation,
              width: 24.0,
            ),
            title: const Text(
              'Alamat',
              style: TextStyle(
                color: ColorName.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ShippingAddressPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: ColorName.primary,
              size: 24.0,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: ColorName.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            onTap: () async {
              await AuthLocalDatasource().removeAuthData();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
