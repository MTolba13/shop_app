part of 'shop_login_cubit.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  final ShopLogingModel logingModel;

  ShopLoginSuccessState(this.logingModel);
}

class ShopLoginErrorState extends ShopLoginState {
  final String error;
  ShopLoginErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopLoginState {}
