// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories_screen.dart';
import 'package:shop_app/modules/favorits_screen.dart';
import 'package:shop_app/modules/products_screen.dart';
import 'package:shop_app/modules/settings_screen.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio.dart';
import 'package:shop_app/shared/constants.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritsScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favourites = {};

  void getHomeData() async {
    emit(ShopLoadingHomeDataState());
    print(token);
    await DioHelper.get(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favourites.addAll({
          element.id: element.inFavorites,
        });
      });
      // print(favourites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      ShopErrorHomeDataState();
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() async {
    await DioHelper.get(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      ShopErrorCategoriesState();
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favourites[productId] != favourites[productId];
    emit(ShopSuccessChangeFavoritesState());

    DioHelper.post(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel.status) {
        favourites[productId] != favourites[productId];
      }

      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error) {
      emit(ShopErrorChangeFavoritesState());
    });
  }

  ShopLogingModel? userModel;

  void getUserData() async {
    emit(ShopLoadingUserDataState());
    await DioHelper.get(
      url: PROFILE,
      token: token,
    ).then(
      (value) {
        userModel = ShopLogingModel.fromJson(value.data);

        emit(ShopSuccessUserDataState(userModel!));
        // print(userModel!.data.id.toString());
      },
    ).catchError(
      (error) {
        print(error.toString());
        emit(ShopErrorUserDataState());
      },
    );
  }
}
