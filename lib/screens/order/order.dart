import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/provider/order_provider.dart';
import 'package:shop_app/screens/favorite/favorite.dart';
import 'package:shop_app/screens/membership/membership.dart';
import 'package:shop_app/screens/order/components/delevering_order_tab.dart';
import 'package:shop_app/screens/order/components/delivered_order_tab.dart';


class MyOrder extends StatelessWidget {
  static String routeName = "/my_order";

  @override
  Widget build(BuildContext context) {
    final ordProvider = Provider.of<OrderProvider>(context);
    User? user = FirebaseAuth.instance.currentUser;

    List<Order> orderDelivering=[];
    List<Order> orderDelivered=[];


    for (int i = 0;i < ordProvider.orders.length ; i++){
      if((ordProvider.orders[i].uId == user!.uid)&&(ordProvider.orders[i].status == 0)){
        orderDelivered.add(ordProvider.orders[i]);
      }
    }

    for (int i = 0;i < ordProvider.orders.length ; i++){
      if((ordProvider.orders[i].uId == user!.uid)&&(ordProvider.orders[i].status == 1)){
        orderDelivering.add(ordProvider.orders[i]);
      }
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: new IconThemeData(
              color: kPrimaryColor),
          title: Text("My Order",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(255, 79, 119, 45),),),
          bottom: TabBar(
            isScrollable: false,
            indicatorColor: kPrimaryColor,
            unselectedLabelColor: kSecondaryColor,
            tabs: [
              Tab(icon: RichText(
                text: TextSpan(
                  text: 'Delivering ',
                  style:  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(text:orderDelivering.length == 0 ? " " : "${orderDelivering.length}" ,style: TextStyle(fontSize: 12, color: kSecondaryColor )),
                  ],
                ),
              )),
              Tab(icon: RichText(
                text: TextSpan(
                  text: 'Delivered ',
                  style:  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(text: orderDelivered.length == 0 ? " " : "${orderDelivered.length}" ,style: TextStyle(fontSize: 12)),
                  ],
                ),
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DeliveringOrderTab(),
            DeliveredOrderTab(),
          ],
        ),
      ),
    );
  }
}

