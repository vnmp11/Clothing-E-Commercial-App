import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/order_provider.dart';
import 'package:shop_app/screens/order/components/delivering_order_card.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/home/components/home_header.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/screens/home/components/special_offer.dart';
import 'package:shop_app/screens/products/products.dart';

import '../../../../size_config.dart';
import '../../../constants.dart';


class DeliveringOrderTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var ordProvider = Provider.of<OrderProvider>(context);
    List<Order> orderUser=[];
    User? user = FirebaseAuth.instance.currentUser;

    for (int i = 0;i < ordProvider.orders.length ; i++){
      if((ordProvider.orders[i].uId == user!.uid)&&(ordProvider.orders[i].status == 1)){
        orderUser.add(ordProvider.orders[i]);
      }
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(5)),
        child: ListView.builder(
          itemCount: orderUser.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(5)),
            child: DeliveringOrderCard( order: orderUser[index]),
          ),
        ),
      ),
    );
  }
}

