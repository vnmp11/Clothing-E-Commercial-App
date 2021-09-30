import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/dialog.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/services/database_manager.dart';


class MyDialog {
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(color: kPrimaryColor,),
          Container(margin: EdgeInsets.only(left: 10),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  showCompleteDialog(BuildContext context, String title){
    AlertDialog alert = AlertDialog(
      content: Text(title),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("OK", style: TextStyle(color: kPrimaryColor),),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  showLogoutDialog(BuildContext context){
    SharedPreferences prefs;
    AlertDialog alert = AlertDialog(
      content: Text("Are you sure you want to logout?"),
      actions: <Widget>[

             FlatButton(
              child: new Text("Cancel", style: TextStyle(color: kPrimaryColor),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: new Text("Ok", style: TextStyle(color: kPrimaryColor),),
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                Fluttertoast.showToast(msg: "Logout successful.");
                prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute( builder: (BuildContext context) => SignInScreen(),
                ), (route) => false,
                );
              },
            ),

      ],
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}