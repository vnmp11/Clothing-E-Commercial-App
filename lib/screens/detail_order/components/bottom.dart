import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/dialog.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/order_provider.dart';
import 'package:shop_app/screens/cart/components/address.dart';
import 'package:shop_app/screens/cart/components/body.dart';
import 'package:shop_app/screens/success/success.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import "package:intl/intl.dart";


class BottomCard extends StatefulWidget {
  @override
  _BottomCardState createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {

  double totalPrice = 0;
  double shipFee = 30000;
  double point = 0;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -25),
            blurRadius: 10,
            color: Color(0xFFDADADA).withOpacity(0.18),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sub total: ",
                  style: TextStyle(fontSize: 14, color: kSecondaryColor, fontWeight:  FontWeight.w500),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    NumberFormat.simpleCurrency(locale: 'vi').format(totalPrice).toString(),
                    style: TextStyle(fontSize: 14, color: kPrimaryColor, fontWeight:  FontWeight.w600),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping fee: ",
                  style: TextStyle(fontSize: 16, color: kSecondaryColor, fontWeight:  FontWeight.w500),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    NumberFormat.simpleCurrency(locale: 'vi').format(shipFee).toString(),
                    style: TextStyle(fontSize: 16, color: kPrimaryColor, fontWeight:  FontWeight.w600),
                  ),
                )
              ],
            ),

            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TOTAL: ",
                  style: TextStyle(fontSize: 18, fontWeight:  FontWeight.w600, color: kPrimaryColor),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      NumberFormat.simpleCurrency(locale: 'vi').format(totalPrice + shipFee).toString(),
                    style: TextStyle(fontSize: 20, color: kPrimaryColor, fontWeight:  FontWeight.w700),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

