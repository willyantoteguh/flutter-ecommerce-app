import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/authentication/auth_local_datasource.dart';
import 'presentation/authentication/bloc/login/login_bloc.dart';
import 'presentation/authentication/bloc/register/register_bloc.dart';
import 'presentation/authentication/login_page.dart';
import 'presentation/cart/bloc/cart_bloc/cart_bloc.dart';
import 'presentation/cart/bloc/order_bloc/order_bloc.dart';
import 'presentation/dashboard/dashboard_page.dart';
import 'presentation/home/bloc/products/products_bloc.dart';
import 'presentation/payment/order_detail_bloc/order_detail_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
            create: (context) =>
                ProductsBloc()..add(const ProductsEvent.getAll())),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => OrderDetailBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
          future: AuthLocalDatasource().isLogin(),
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.data!) {
              return const DashboardPage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
