part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitialState extends ShopState {}

class ShopChangeBottomNavState extends ShopState {}

class ShopLoadingHomeDataState extends ShopState {}

class ShopSuccessHomeDataState extends ShopState {}

class ShopErrorHomeDataState extends ShopState {}

class ShopSuccessCategoriesState extends ShopState {}

class ShopErrorCategoriesState extends ShopState {}

class ShopSuccessChangeFavoritesState extends ShopState {}

class ShopErrorChangeFavoritesState extends ShopState {}

class ShopLoadingUserDataState extends ShopState {}

class ShopSuccessUserDataState extends ShopState {
  final ShopLogingModel logingModel;

  ShopSuccessUserDataState(this.logingModel);
}

class ShopErrorUserDataState extends ShopState {}
