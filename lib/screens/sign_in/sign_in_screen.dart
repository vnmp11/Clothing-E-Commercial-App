import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

import '../../size_config.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(
            color: kPrimaryColor),
        title: Text("Sign In"),
      ),
      body: Body(),
    );
  }
}
