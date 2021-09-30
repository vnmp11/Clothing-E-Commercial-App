import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.1),
        Image.asset(
          "assets/images/checked.png",
          height: SizeConfig.screenHeight * 0.6, //40%
        ),

        Text(
          "Login Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255,79, 119, 45),
          ),
        ),
        Spacer(flex: 3),
        SizedBox(
          width: SizeConfig.screenWidth * 0.8,
          child: DefaultButton(
            text: "Go to home ",
            press: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false,
              );

            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
