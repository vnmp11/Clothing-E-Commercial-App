import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/dialog.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/screens/cart/components/body.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import "package:intl/intl.dart";


class AddtoCartCard extends StatefulWidget {

   Product product;
  int numOfItems = 1;

   AddtoCartCard({Key? key, required this.product}) : super(key: key);

  @override
  _AddtoCartCard createState() => _AddtoCartCard();
}
class _AddtoCartCard extends State<AddtoCartCard> {
  @override
  Widget build(BuildContext context) {

    var document =  FirebaseFirestore.instance.collection('Cart').doc();
    var documentUuid = document.id;


    final cartProvider = Provider.of<CartProvider>(context);
    Cart cartadd = Cart();
    cartadd.price = widget.product.price;
    cartadd.name= widget.product.title;
    cartadd.proID= widget.product.id;
    cartadd.image= widget.product.images[0];
    cartadd.status = false;
    //chua co gia tri
    User? user = FirebaseAuth.instance.currentUser;
    cartadd.uID= user!.uid ;
    final _auth= FirebaseAuth.instance;

    //cartadd.cartID = documentUuid;
    cartadd.numOfItem = widget.numOfItems;

    bool test =false;
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -20),
            blurRadius: 10,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

                    Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundedIconBtn(
                              icon: Icons.remove_circle_outline,
                              showShadow: true,
                              press: () {
                                if (  widget.numOfItems > 1) {
                                  setState(() {
                                    widget.numOfItems--;
                                  });
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0 / 2),
                              child: Text(
                                // if our item is less  then 10 then  it shows 01 02 like that
                                  widget.numOfItems.toString().padLeft(2, "0"),
                                  style: TextStyle(
                                      fontSize: 18, color: kSecondaryColor, fontWeight: FontWeight.w500)
                              ),
                            ),
                            RoundedIconBtn(
                              icon: Icons.add_circle_outline,
                              showShadow: true,
                              press: () {
                                setState(() {
                                  widget.numOfItems++;
                                });
                              },
                            ),
                          ],
                        )),
                    SizedBox(width: getProportionateScreenWidth(10)),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.05,
                          right: SizeConfig.screenWidth * 0.05,
                          bottom: getProportionateScreenWidth(5),
                          top: getProportionateScreenWidth(10),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {
                            Fluttertoast.showToast(msg: "Added to cart.");
                            for(int i = 0;i<cartProvider.carts.length;i++){

                              if((cartProvider.carts[i].uID == user.uid) && (cartProvider.carts[i].proID == widget.product.id) && (cartProvider.carts[i].status == false) ){
                                DocumentReference ref = FirebaseFirestore.instance.collection("Cart").doc(cartProvider.carts[i].cartID);
                                ref.update({
                                  'numOfItem':cartProvider.carts[i].numOfItem + widget.numOfItems,
                                });

                                cartProvider.carts[i].numOfItem += widget.numOfItems;
                                test =true;

                              }
                            }
                            if(test == false){
                              DocumentReference ref1 = FirebaseFirestore.instance.collection("Cart").doc();
                              ref1.set({
                                'image': widget.product.images[0],
                                'name': widget.product.title,
                                'numOfItem': widget.numOfItems,
                                'price': widget.product.price,
                                'proID': widget.product.id,
                                'status':false,
                                'uID':user.uid,
                                "cartID": ref1.id,

                              });
                              cartadd.cartID = ref1.id;
                              cartProvider.carts.add(cartadd);
                            }

                          },
                        ),
                      ),
                    ),
                  ],
        ),
      ),
    );
  }
}

