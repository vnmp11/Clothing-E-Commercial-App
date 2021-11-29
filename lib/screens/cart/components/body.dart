import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';
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
    print (cartUser.length);
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
                //FirebaseFirestore firestore = ;
                print(cartUser[index].cartID);
                FirebaseFirestore.instance.collection('Cart').doc(cartUser[index].cartID).delete();


                cartProvider.carts.removeAt(index);
                cartUser.removeAt(index);





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
