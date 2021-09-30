import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/edit_profile/body.dart';


class EditProfile extends StatelessWidget {
  static String routeName = "/edit_profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(
            color: kPrimaryColor),
        title: Text("My Account", style: TextStyle(color: kPrimaryColor),),
      ),
      body: Body(),
    );
  }
}