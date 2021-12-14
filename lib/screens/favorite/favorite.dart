import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/screens/details_product/details_screen.dart';

import '../../constants.dart';
import 'body.dart';


class FavoriteScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: new IconThemeData(
              color: kPrimaryColor),
        title: Text("My Favorite",
        textAlign: TextAlign.center,
        style: TextStyle(color: Color.fromARGB(255, 79, 119, 45),),)
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
}
