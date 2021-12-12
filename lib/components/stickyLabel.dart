import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';


class StickyLabel extends StatelessWidget {
  final String text;
  final Color textColor;
  const StickyLabel({
     Key? key,
    required this.text,
     required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
        top: getProportionateScreenWidth(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
