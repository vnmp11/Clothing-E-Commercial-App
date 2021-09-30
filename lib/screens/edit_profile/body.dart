import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/dialog.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/profile/components/profile_pic.dart';
import 'package:shop_app/services/database_manager.dart';

import '../../../size_config.dart';
import '../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              ProfilePic(),

              Text(
                "You can change your detail profile",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              EditForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class EditForm extends StatefulWidget {
  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection("Users").doc(user!.uid)
    .get().then((value){
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
          emailcontroller.text = "${loggedInUser.Email}";
          phonecontroller.text = "${loggedInUser.Phone}";
          addresscontroller.text = "${loggedInUser.Address}";
          namecontroller.text = "${loggedInUser.Name}";

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            enabled: false,
            controller: emailcontroller,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            decoration: InputDecoration(
              labelText: "Email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(25)),
          TextFormField(
            controller: namecontroller,
            keyboardType: TextInputType.text,
            onSaved: (newValue) => email = newValue,
            decoration: InputDecoration(
              labelText: "Name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(25)),
          TextFormField(
            controller: phonecontroller,
            keyboardType: TextInputType.number,
            onSaved: (newValue) => email = newValue,
            decoration: InputDecoration(
              labelText: "Phone Number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(25)),
          TextFormField(
            controller: addresscontroller,
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            decoration: InputDecoration(
              labelText: "Address",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          DefaultButton(
            text: "Save",
            press: () =>
            {
              pressSavebutton(),
            }
          ),
          
          SizedBox(height: SizeConfig.screenHeight * 0.1),

        ],
      ),
    );
  }

  pressSavebutton() async {
    MyDialog().showLoaderDialog(context);
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
    MyDialog().showCompleteDialog(context, "Updated your profile.");
    await DatabaseManager().updateDataUser(namecontroller.text, phonecontroller.text, addresscontroller.text, user!.uid);
  }



}
