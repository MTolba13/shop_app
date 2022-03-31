import 'package:shop_app/models/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(
        context,
        const LoginScreen(),
      );
    }
  });
}

String? token = '';

String baseUrl = 'https://student.valuxapps.com/api/';
