// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shop_app/components/dialog.dart';
// import 'package:shop_app/components/product_card.dart';
// import 'package:shop_app/models/Product.dart';
// import 'package:shop_app/screens/edit_profile/edit_profile.dart';
// import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
//
// import '../../../constants.dart';
// import '../../size_config.dart';
//
//
// class Body extends StatelessWidget {
//   late SharedPreferences prefs;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(getProportionateScreenWidth(10)),
//         child: GridView.builder(
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 200,
//                 childAspectRatio: 0.7,
//                 crossAxisSpacing: 5,
//                 mainAxisSpacing: 10),
//             itemCount: demoProducts.length,
//             itemBuilder: (BuildContext ctx, index) {
//               return ProductCard(product: demoProducts[index]);
//             }),
//       ),
//     );
//   }
//
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/dialog.dart';
import 'package:shop_app/components/favorite_card.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Favorite.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/screens/edit_profile/edit_profile.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import '../../../constants.dart';
import '../../size_config.dart';


class Body extends StatefulWidget {

  _BodyState createState() => _BodyState();
}
class _BodyState extends State<Body>{

  late SharedPreferences prefs;
  User? user = FirebaseAuth.instance.currentUser;
  FavoriteModel favModel = FavoriteModel();
  bool check = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collection = "product";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favProvider =  Provider.of<FavoriteProvider>(context, listen: false);

    // print("provider: "+favProvider.products.length.toString() );
    return Scaffold(
      body: Padding(

        padding: EdgeInsets.only(left: getProportionateScreenWidth(5),
            right: getProportionateScreenWidth(10)),

        // child: GridView.builder(
        //     gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //         maxCrossAxisExtent: 200,
        //         childAspectRatio: 0.7,
        //         crossAxisSpacing: 5,
        //         mainAxisSpacing: 10),
        //     itemCount: favProvider.products.length,
        //     itemBuilder: (BuildContext ctx, index) {
        //         return FavoriteCard(
        //             product: favProvider.products[index]);
        //     }
        child: ListView.builder(
          itemCount: favProvider.products.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(20), right: getProportionateScreenWidth(20),bottom: getProportionateScreenWidth(10), top: getProportionateScreenWidth(10), ),
            child: FavoriteCard( product: favProvider.products[index]),
            ),
          ),
        ),

    );
  }
}
