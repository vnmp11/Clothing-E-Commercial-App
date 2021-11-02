import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/models/Product.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'body.dart';

class ProductScreen extends StatelessWidget {
  static String routeName = "/products";
  final String title;
  final List<Product> product;
  ProductScreen({required this.title, required this.product});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context,title),
      body: Body(product),
    );
  }
}

AppBar buildAppBar(BuildContext context, String title) {
  return AppBar(
    iconTheme: new IconThemeData(
        color: kPrimaryColor),
    title: Column(
      children: [

        Text(
          "$title",
          style: TextStyle(color: Color.fromARGB(255, 79, 119, 45),),
        ),
      ],
    ),
  );
}