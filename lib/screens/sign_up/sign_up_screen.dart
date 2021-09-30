import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(
            color: kPrimaryColor),
        title: Text("Sign Up"),
      ),
      body: Body(),
    );
  }
}
