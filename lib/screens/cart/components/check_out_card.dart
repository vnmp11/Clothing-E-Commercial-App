import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/provider/cart_provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    double totalPrice = 0;
    int countItems =0;
    List<Cart> cartUser=[];
    User? user = FirebaseAuth.instance.currentUser;
    for (int i=0;i<cartProvider.carts.length;i++){
      if((cartProvider.carts[i].uID==user!.uid)&&(cartProvider.carts[i].status==false)){
        cartUser.add(cartProvider.carts[i]);
        totalPrice = totalPrice + (cartProvider.carts[i].price*cartProvider.carts[i].numOfItem);
        //print('ok1');
        countItems += cartProvider.carts[i].numOfItem;
      }
    }
    print(cartUser.length);
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
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: totalPrice.toString(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () async {
                      List yourItemList = [];
                      for (int i = 0; i < cartUser.length; i++)
                        yourItemList.add({
                          "name": cartUser[i].name,
                          "price": cartUser[i].price,
                          "numOfItem": cartUser[i].numOfItem,
                          "proID":cartUser[i].proID,
                          "cartID":cartUser[i].cartID,
                        });

                      DocumentReference ref = FirebaseFirestore.instance.collection('Bill').doc();
                      ref.set({
                        "uID":cartUser[0].uID ,
                        "listCart": FieldValue.arrayUnion(yourItemList),
                        "billID": ref.id,
                        "totalPrice": totalPrice,
                        "status": 1,

                      });

                      // int a =cartProvider.carts.length;
                      // for(int i = 0; i < a; i++){
                      //   if(cartProvider.carts[i].uID == user!.uid){
                      //     cartProvider.carts.remove(cartProvider.carts[i]);
                      //
                      //   }
                      // }

                      for(int i = 0; i < cartProvider.carts.length; i++) {
                        if(cartProvider.carts[i].uID == user!.uid) {
                          DocumentReference ref1 = FirebaseFirestore.instance.collection('Cart').doc(cartProvider.carts[i].cartID);
                          ref1.update({
                            "status": true,
                          });
                          cartProvider.carts[i].status = true;
                        }
                      }


                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
