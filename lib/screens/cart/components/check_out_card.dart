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
import 'package:shop_app/provider/user_provider.dart';
import 'package:shop_app/screens/cart/components/address.dart';
import 'package:shop_app/screens/cart/components/body.dart';
import 'package:shop_app/screens/success/success.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import "package:intl/intl.dart";


class CheckoutCard extends StatefulWidget {
  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {

  double shipFee = 30000;
  double point = 0;
  double discount = 0;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();


  @override
    Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    int countItems =0;
    List<Cart> cartUser=[];
    double totalPrice = 0;
    // get cart
    for (int i=0;i<cartProvider.carts.length;i++){
      if((cartProvider.carts[i].uID==user!.uid)&&(cartProvider.carts[i].status==false)){
          cartUser.add(cartProvider.carts[i]);
          totalPrice = totalPrice + (cartProvider.carts[i].price*cartProvider.carts[i].numOfItem);
          countItems += cartProvider.carts[i].numOfItem;
      }
    }
    // print("cart: "+ cartUser.length.toString());
    // for (int i=0;i<cartUser.length;i++) {
    //   totalPrice = totalPrice + (cartUser[i].price*cartUser[i].numOfItem);
    // }
    // print("totalprice: "+totalPrice.toString());
    FirebaseFirestore.instance.collection("Users").doc(user!.uid)
        .get().then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        point = loggedInUser.Point!;
        discount = loggedInUser.Discount!;
      });
    });

    // set fee ship
    if (cartUser.length == 0)
    {
      shipFee = 0;
    }

    if (totalPrice >= 1000000)
    {
      shipFee = 0;
    }

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
                  "Discount: ",
                  style: TextStyle(fontSize: 14, color: kSecondaryColor, fontWeight:  FontWeight.w500),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    (discount*100).toString() + " %",
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
                  style: TextStyle(fontSize: 14, color: kSecondaryColor, fontWeight:  FontWeight.w500),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    NumberFormat.simpleCurrency(locale: 'vi').format(shipFee).toString(),
                    style: TextStyle(fontSize: 14, color: kPrimaryColor, fontWeight:  FontWeight.w600),
                  ),
                )
              ],
            ),

            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "TOTAL:\n",
                    style: TextStyle(fontSize: 14, fontWeight:  FontWeight.w600),
                    children: [
                      TextSpan(
                        text: NumberFormat.simpleCurrency(locale: 'vi').format(totalPrice-(totalPrice*discount) + shipFee).toString(),
                        style: TextStyle(fontSize: 18, color: kPrimaryColor, fontWeight:  FontWeight.w700),
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
                          "uID":user!.uid,
                          "status": true,
                          "name": cartUser[i].name,
                          "image": cartUser[i].image,
                          "price": cartUser[i].price,
                          "numOfItem": cartUser[i].numOfItem,
                          "proID":cartUser[i].proID,
                          "cartID":cartUser[i].cartID,
                        });

                      if (yourItemList.length != 0)
                        {


                          DocumentReference ref = FirebaseFirestore.instance.collection('Order').doc();

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DeliveryAddress(ref.id),
                            ),);

                          ref.set({
                            "uID":cartUser[0].uID ,
                            "listCart": FieldValue.arrayUnion(yourItemList),
                            "billID": ref.id,
                            "subTotal": totalPrice,
                            "feeShip": shipFee,
                            "discount": discount,
                            "totalPrice": totalPrice-(totalPrice*discount) + shipFee,
                            "status": 1,
                            "date": DateTime.now(),
                            "totalItem" : yourItemList.length,
                            "address" : " "

                          });

                          Order orderadd = Order();
                          orderadd.id = ref.id;
                          orderadd.subTotal = totalPrice;
                          orderadd.totalPrice = totalPrice-(totalPrice*discount) + shipFee;
                          orderadd.feeShip = shipFee;
                          orderadd.date = DateFormat('dd/MM/yyyy hh:mm').format(DateTime.now());
                          orderadd.totalItem = yourItemList.length;
                          orderProvider.orders.add(orderadd);
                          orderadd.uId = user!.uid;
                          orderadd.discount = discount;
      
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

                          //Update the point of user
                          DocumentReference ref1 = FirebaseFirestore.instance.collection('Users').doc(user!.uid);
                          if ( point+totalPrice >= 10000000)
                          {
                            discount = 0.25;
                          }
                          else if (point+totalPrice > 5000000)
                          {
                            discount = 0.2;
                          }else if(point+totalPrice > 3000000)
                          {
                            discount = 0.1;
                          }
                          ref1.update({
                            "Point": point+totalPrice,
                            "Discount": discount,
                          });


                        }else
                          {
                            MyDialog().showNoti(context, "Your cart is empty.");
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

