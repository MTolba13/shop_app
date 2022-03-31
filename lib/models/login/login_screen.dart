// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/models/login/cubit/shop_login_cubit.dart';
import 'package:shop_app/modules/register_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components.dart';

var formKey = GlobalKey<FormState>();

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.logingModel.status) {
              print(state.logingModel.data.token);
              print(state.logingModel.message);
              CacheHelper.saveData(
                      key: 'token', value: state.logingModel.message)
                  .then((value) {
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              print(state.logingModel.message);
              showToast(
                text: state.logingModel.message.toString(),
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: HexColor('E1095B'),
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'login now to browse our hot offer',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password ',
                          prefix: Icons.lock_outline_rounded,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSumbit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          suffix: ShopLoginCubit.get(context).suffix,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your Password';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          builder: (context) => MaterialButton(
                            textColor: Colors.white,
                            elevation: 10,
                            focusElevation: 20,
                            color: HexColor('E1095B'),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: const Text('LOGIN'),
                          ),
                          condition: state is! ShopLoginLoadingState,
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            navigateTo(
                              context,
                              const RegisterScreen(),
                            );
                          },
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
