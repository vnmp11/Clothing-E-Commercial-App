import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class OrderCard extends StatelessWidget {
  OrderCard({
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
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
      child: Container(
          margin: EdgeInsets.all(5) ,
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(

                  children: <Widget>[
                     ListTile(
                       isThreeLine: true,
                       horizontalTitleGap: 8, //Set this.
                       minLeadingWidth: 10,

                      leading: Container(
                        child:
                        Icon(Icons.article_rounded, color: kPrimaryColor),),
                      title: Padding(padding: EdgeInsets.only(top: 10),child: new Text('${order.id.toString()}', style: TextStyle(color: kPrimaryColor, fontSize: 18), ),),
                      subtitle: Text("Total price: "+'${order.price.toString()}'+"\nTotal item: "+'${order.item.toString()}'),
                    ),

                    ButtonBarTheme ( // make buttons use the appropriate styles for cards
                      data: ButtonBarThemeData(),
                      child: ButtonBar(
                        children: <Widget>[
                          TextButton(
                            child: const Text('Show More >', style: TextStyle(color: kPrimaryColor),),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                elevation: 5,

              ),
            ],
          )
      )
    );
  }


}


