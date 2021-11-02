import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/User.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatefulWidget {
  @override
  _DiscountBanner createState() => _DiscountBanner();


}

class _DiscountBanner extends State<DiscountBanner> {

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
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(20),
      ),
      decoration: BoxDecoration(
        color: Color(0xFF5B8834),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "${loggedInUser.Name},\n",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(15),
              ),),
            TextSpan(
              text: "Welcome to NewLOOK!",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
