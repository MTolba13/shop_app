import 'package:flutter/material.dart';

class FavouritsScreen extends StatelessWidget {
  const FavouritsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Products Screen',
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
