import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/components/dialog.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/cart/components/check_out_card.dart';
import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    print (cartProvider.carts.length);
    List<Cart> cartUser=[];
    User? user = FirebaseAuth.instance.currentUser;


    for (int i=0;i<cartProvider.carts.length;i++){
      if((cartProvider.carts[i].uID==user!.uid)&&(cartProvider.carts[i].status==false)){
        cartUser.add(cartProvider.carts[i]);
      }
    }

    print (cartProvider.carts.length);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: cartUser.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(()  {
                print("id:" + cartUser[index].cartID);
                FirebaseFirestore.instance.collection('Cart').doc(cartUser[index].cartID).delete();

                cartProvider.carts.remove(cartUser[index]);
                cartUser.removeAt(index);

                Fluttertoast.showToast(msg: "Deleted successfully!");
                Navigator.popAndPushNamed(context,CartScreen.routeName);

              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: CartCard(cart: cartUser[index] ),
          ),
        ),
      ),
    );

  }

}
