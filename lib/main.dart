// ignore_for_file: unused_label, unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/bloc_observer.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/models/login/cubit/shop_login_cubit.dart';
import 'package:shop_app/models/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/styles/themes.dart';

void main() async {
  BlocOverrides.runZoned(
    () {
      AppCubit();
      ShopLoginCubit();
      ShopCubit();
    },
    blocObserver: MyBlocObserver(),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({
    Key? key,
    required this.startWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
        BlocProvider(
          create: (context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,

            // darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
