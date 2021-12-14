import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/screens/detail_order/components/bottom.dart';
import 'package:shop_app/screens/review/defaultAppBar.dart';
import 'package:shop_app/screens/review/defaultBackButton.dart';
import 'package:shop_app/size_config.dart';

import 'components/body.dart';

class DetailOrder extends StatelessWidget {
  static String routeName = "/detailorder";

  DetailOrder(String this.id, {Key? key}) : super(key: key);
  String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(id),
      bottomNavigationBar: BottomCard(id),
    );


  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      iconTheme: new IconThemeData(
          color: kPrimaryColor),
      centerTitle: true,
      title:  Padding(padding: EdgeInsets.all(getProportionateScreenWidth(5)),
        child:Column(
        children: [
          Text(
            "Detail Order",
            style: TextStyle(color: Color.fromARGB(255, 79, 119, 45), fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 3),
          Text(
            "Order No: " + id,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.left,
          )
        ],
      ),)
    );
  }

}