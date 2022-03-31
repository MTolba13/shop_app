// ignore: duplicate_ignore
// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: non_constant_identifier_names
void navigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Widget),
      (Route) => false,
    );

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        required String label,
        required IconData prefix,
        IconData? suffix,
        required var validate,
        bool isPassword = false,
        var suffixPressed,
        void Function(String)? onSumbit,
        var onTap,
        dynamic onChange}) =>
    TextFormField(
      onFieldSubmitted: onSumbit,
      onChanged: onChange,
      onTap: onTap,
      obscureText: isPassword,
      validator: validate,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: HexColor('735c65'),
        ),
        suffixIcon: IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
            color: HexColor('E1095B'),
          ),
        ),
        labelText: label,
        prefixIcon: Icon(
          prefix,
          color: HexColor('E1095B'),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: HexColor('E1095B'))),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: HexColor('E1095B')),
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
      ),
    );

void showToast({
  required String text,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 15,
    );


    Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.teal,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          function();
        },
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
