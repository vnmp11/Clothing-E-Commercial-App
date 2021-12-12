
import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/emptySection.dart';
import 'package:shop_app/components/subTitle.dart';
import 'package:shop_app/screens/home/home_screen.dart';

import '../../size_config.dart';

class SuccessScreen extends StatefulWidget {
  static String routeName = "/success";

  SuccessScreen({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptySection(
            emptyImg: 'assets/images/success.gif',
            emptyMsg: 'Successful !!',
          ),
          SubTitle(
            subTitleText: 'Your order was done successfully',
          ),
          Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
          child:DefaultButton(
            text: 'Continue Shopping',
            press: () => Navigator.popAndPushNamed(context,HomeScreen.routeName)
          ),
          )
        ],
      ),
    )
    );
  }
}
