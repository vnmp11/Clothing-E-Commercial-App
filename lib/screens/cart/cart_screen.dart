import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/provider/cart_provider.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {

    final cartProvider = Provider.of<CartProvider>(context);
    List<Cart> cartUser=[];
    User? user = FirebaseAuth.instance.currentUser;

    for (int i=0;i<cartProvider.carts.length;i++){
      if((cartProvider.carts[i].uID==user!.uid)&&(cartProvider.carts[i].status==false)){
        cartUser.add(cartProvider.carts[i]);
      }
    }

    return AppBar(
      elevation: 1,
      iconTheme: new IconThemeData(
          color: kPrimaryColor),
      centerTitle: true,
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Color.fromARGB(255, 79, 119, 45), fontWeight: FontWeight.w600),
          ),
          Text(
            cartUser.length==1 ? "1 item": "${cartUser.length} items",
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.left,
          ),

        ],
      ),
    );
  }
}
