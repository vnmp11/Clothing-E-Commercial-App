import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/detail_order/detail_delivered_order.dart';
import 'package:shop_app/screens/detail_order/detail_order.dart';
import 'package:shop_app/screens/details_product/details_screen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

TextEditingController reviewcontroller = new TextEditingController();
String? review;
double? rate = 1;

class DeliveredOrderCard extends StatelessWidget {
  DeliveredOrderCard({
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
    return  GestureDetector(
        onTap: ()
    {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DetailDeliveredOrder(order.id)));
    },
    child: SingleChildScrollView(child:Padding(
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
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: EdgeInsets.only(bottom: getProportionateScreenHeight(130)),
                              child: Icon(Icons.article_rounded, color: kPrimaryColor),
                            ),
                          ),
                          SizedBox(width: 20),
                          Flexible(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: 5),
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
                              Container(
                                child: RaisedButton.icon(
                                  onPressed: (){ Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => DetailDeliveredOrder(order.id)));
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  label: Text('Rate',
                                    style: TextStyle(color: Colors.white, fontSize: 14),),
                                  icon: Icon(Icons.rate_review_outlined, color:Colors.white,size: 18,),
                                  textColor: Colors.white,
                                  splashColor: kSecondaryColor,
                                  color: Color(0xFF679A3B),),
                                alignment: Alignment.bottomRight,
                              ),

                            ],
                          ),),
                        ],
                      )
                  ),

                ),

              ],
            )
        )
    ))
    );
  }


}

openAlertBox(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
         content: SingleChildScrollView(
         scrollDirection: Axis.vertical,
         child: Container(
            width: 400.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding:
                      EdgeInsets.only(right: getProportionateScreenWidth(50)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Rate",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 79, 119, 45),
                                fontWeight: FontWeight.w600,
                              ),
                            ),]
                      ),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      rating: 1,
                      size: 30.0,
                      color:  Color(0xFFFFC416),
                      borderColor:  Color(0xFFFFC416),
                      onRated: (r){
                        rate = r;
                        print(r);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: EdgeInsets.all(getProportionateScreenHeight(10)),
                  child: TextFormField(
                    controller: reviewcontroller,
                    onSaved: (newValue) => review = newValue,
                    onChanged: (value) {
                      review = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Add Review",
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                  ),
                ),
              Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(10)),
                child: DefaultButton(
                  text: "Add Review",
                  press: (){
                      print("rate: "+rate.toString());
                      print("review: "+reviewcontroller.text);
                      Navigator.pop(context);
                  },
                )
              )

              ],
            ),
          ),)
        );
      });
}
