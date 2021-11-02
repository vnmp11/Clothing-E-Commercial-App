import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/order_card.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/home/components/home_header.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/screens/home/components/special_offer.dart';
import 'package:shop_app/screens/products/products.dart';

import '../../../size_config.dart';
import '../../constants.dart';


class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 2.2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemCount: demoOrders.length,
            itemBuilder: (BuildContext ctx, index) {
              return OrderCard(order: demoOrders[index]);
            }),
      ),
    );
  }
}

