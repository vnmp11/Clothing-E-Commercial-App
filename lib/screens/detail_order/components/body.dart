import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/components/dialog.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/cart/components/cart_card.dart';
import 'package:shop_app/screens/cart/components/check_out_card.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  Body(String this.id, {Key? key}) : super(key: key);
  String id;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List <Cart> cart = [];
  List lcart = [];

  Future<List> fetchAllContact() async {
    List listCart = [];
    DocumentSnapshot documentSnapshot =
    await FirebaseFirestore.instance.collection('Order').doc(widget.id).get();
    listCart = documentSnapshot['listCart'];
    return listCart;
  }


  @override
  void initState() {
    super.initState();
    fetchAllContact().then((List list) {
      setState(() {
        lcart = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> cartList =[];
    final cartProvider = Provider.of<CartProvider>(context);

    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: lcart.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                    decoration: BoxDecoration(
                      color: Color(0xFFDDE5B6).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(lcart[index]['image']),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Flexible(child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lcart[index]['name'],
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    maxLines: 2,
                  ),
                  SizedBox(height: 5),
                  Text.rich(
                    TextSpan(
                      text: NumberFormat.simpleCurrency(locale: 'vi').format(lcart[index]['price']).toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: kPrimaryColor),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                "x${lcart[index]['numOfItem']}",
                                style: Theme.of(context).textTheme.bodyText1),

                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

}
