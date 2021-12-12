import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/dialog.dart';
import 'package:shop_app/screens/edit_profile/edit_profile.dart';
import 'package:shop_app/screens/favorite/favorite.dart';
import 'package:shop_app/screens/membership/membership.dart';
import 'package:shop_app/screens/order/order.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import '../../../constants.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => Navigator.pushNamed(context, EditProfile.routeName),
          ),
          ProfileMenu(
            text: "Membership",
            icon: "assets/icons/Membership.svg",
            press: () => Navigator.pushNamed(context, MembershipScreen.routeName),
          ),
          ProfileMenu(
            text: "My Favorite",
            icon: "assets/icons/Heart Icon_1.svg",
            press: () =>   Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>  FavoriteScreen(),
              ),
            ),
          ),
          ProfileMenu(
            text: "My Orders",
            icon: "assets/icons/Bell.svg",
            press: () => Navigator.pushNamed(context, MyOrder.routeName),
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              MyDialog().showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

}
