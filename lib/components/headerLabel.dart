import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

class HeaderLabel extends StatelessWidget {
  final String headerText;
  const HeaderLabel({
    Key? key, required this.headerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenHeight(5)),
      child: Text(
        headerText,
        style: TextStyle(color: kPrimaryColor, fontSize: 20.0),
      ),
    );
  }
}