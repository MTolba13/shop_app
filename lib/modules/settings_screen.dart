// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/shared/components.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  SettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  label: model.data!.name!,
                  prefix: Icons.person,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'name must not be empty';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  label: model.data!.email!,
                  prefix: Icons.email,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Email must not be empty';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  label: model.data!.phone!,
                  prefix: Icons.phone,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Phone must not be empty';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                  function: () {},
                  text: 'LOGOUT',
                ),
              ],
            ),
          ),
          condition: ShopCubit.get(context).userModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
