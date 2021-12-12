import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/home/components/home_header.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/screens/home/components/special_offer.dart';
import 'package:shop_app/screens/products/products.dart';

import '../../../size_config.dart';
import '../../constants.dart';
import 'package:shop_app/provider/product_provider.dart';

class Body extends StatelessWidget {

  final List<Product> product;
  Body( this.product);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(5), right: getProportionateScreenWidth(10)),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.7,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10),
            itemCount: product.length,
            itemBuilder: (BuildContext ctx, index) {
              return ProductCard(product: product[index]);
            }),
      ),
    );
  }
}

