import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/home/components/home_header.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/screens/home/components/special_offer.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';

import 'popular_product.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection("Users").doc(user!.uid)
        .get().then((value){
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children:<Widget> [

            SizedBox(height: getProportionateScreenHeight(10)),
            // Padding(
            //     padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
            //     child: Align(
            //         alignment: Alignment.centerLeft,
            //         child: Container(
            //           child: Text(
            //             "Welcome to NewLOOK, ${loggedInUser.Name}!",
            //             style: TextStyle(
            //                 fontSize: 15
            //             ),
            //           ),))),
            SizedBox(height: getProportionateScreenHeight(15)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(5)),
            DiscountBanner(),
            Categories(),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }

}





