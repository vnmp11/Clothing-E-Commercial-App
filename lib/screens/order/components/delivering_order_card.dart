import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/detail_order/detail_order.dart';
import 'package:shop_app/screens/details_product/details_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class DeliveringOrderCard extends StatelessWidget {
  DeliveringOrderCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.order,
  }) : super(key: key);

  final double width, aspectRetio;
  final Order order;
  Color _colorFav = Color(0xFFDBDEE4);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
        {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>DetailOrder(order.id)));
        },
      child: Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
      child: Container(
          margin: EdgeInsets.all(5) ,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: kSecondaryColor.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.article_rounded, color: kPrimaryColor),
                      SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Order No: ',style: TextStyle(fontSize: 16, color: kPrimaryColor, fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: order.id,
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 16)),

                          ]),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Items Count: ',style: TextStyle(fontSize: 14, color: kSecondaryColor, fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: order.totalItem.toString(),
                                style: TextStyle(
                                    color: kSecondaryColor, fontSize: 14)),

                          ]),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Total Price: ',style: TextStyle(fontSize: 14, color: kSecondaryColor, fontWeight: FontWeight.w600)),
                            TextSpan(
                                text:  NumberFormat.simpleCurrency(locale: 'vi').format(order.totalPrice).toString(),
                                style: TextStyle(
                                    color: kSecondaryColor, fontSize: 14)),

                          ]),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'Order Date: ',style: TextStyle(fontSize: 14, color: kSecondaryColor, fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: order.date,
                                style: TextStyle(
                                    color: kSecondaryColor, fontSize: 14)),

                          ]),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    ],
                  )
                ),

              ),
            ],
          )
      )
      )
    );
  }


}


