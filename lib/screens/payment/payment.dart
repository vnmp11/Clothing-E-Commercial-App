import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/emptySection.dart';
import 'package:shop_app/components/headerLabel.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/review/defaultAppBar.dart';
import 'package:shop_app/screens/review/defaultBackButton.dart';
import 'package:shop_app/screens/success/success.dart';

import '../../size_config.dart';

class PaymentScreen extends StatefulWidget {
  static String routeName = "/payment";

  PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<PaymentScreen> {
  bool _value = false;
  int? val = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: 'Payment',
        child: DefaultBackButton(),
      ),
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            EmptySection(
              emptyImg: 'assets/images/payment.gif',
              emptyMsg: '',
            ),
            HeaderLabel(
              headerText: 'Choose your payment method',
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: Radio(
                    value: 1,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value as int?;
                      });
                    },
                    activeColor: kPrimaryColor,
                  ),
                  title: Text(
                    'Credit card / Debit card',
                    style: TextStyle(color: kDarkColor),
                  ),
                  trailing: Icon(Icons.credit_card, color: kPrimaryColor),
                ),
                ListTile(
                  leading: Radio(
                    value: 2,
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value as int?;
                      });
                    },
                    activeColor: kPrimaryColor,
                  ),
                  title: Text(
                    'Cash on delivery',
                    style: TextStyle(color: kDarkColor),
                  ),
                  trailing: Icon(Icons.attach_money, color: kPrimaryColor),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            DefaultButton(
                text: "Pay",
                press: () =>
                {
                  Navigator.popAndPushNamed(context, SuccessScreen.routeName)
                }
            ),

          ],
        ),
      ),
    );
  }
}
