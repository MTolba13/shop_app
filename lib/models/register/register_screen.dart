// ignore_for_file: avoid_print, unused_local_variable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/models/login/cubit/shop_login_cubit.dart';
import 'package:shop_app/models/register/cubit/shop_register_cubit.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components.dart';

var formKey = GlobalKey<FormState>();

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.data.token);
              print(state.loginModel.message);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.message)
                  .then((value) {
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message.toString(),
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
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: HexColor('E1095B'),
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Register now to browse our hot offer',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Your Name',
                          prefix: Icons.person,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone Number',
                          prefix: Icons.phone_android_outlined,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your phone';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
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
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password ',
                          prefix: Icons.lock_outline_rounded,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSumbit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          suffix: ShopRegisterCubit.get(context).suffix,
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
                            onPressed: () {},
                            child: const Text('REGISTER'),
                          ),
                          condition: state is! ShopLoginLoadingState,
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
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
