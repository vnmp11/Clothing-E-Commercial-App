import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/order/body.dart';


class MyOrder extends StatelessWidget {
  static String routeName = "/my_order";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(
            color: kPrimaryColor),
        title: Text("My Order", style: TextStyle(color: kPrimaryColor),),
      ),
      body: Body(),
    );
  }
}