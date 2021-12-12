import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/favorite/favorite.dart';
import 'package:shop_app/screens/membership/membership.dart';
import 'package:shop_app/screens/order/components/delevering_order_tab.dart';
import 'package:shop_app/screens/order/components/delivered_order_tab.dart';


class MyOrder extends StatelessWidget {
  static String routeName = "/my_order";

  @override
  Widget build(BuildContext context) {
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
              Tab(icon: Text('Delivering', style: TextStyle(color: kPrimaryColor),)),
              Tab(icon: Text('Delivered', style: TextStyle(color: kPrimaryColor),)),
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