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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/dialog.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
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

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<Product> product =[];
    return Scaffold(
      body: Padding(

        padding: EdgeInsets.all(getProportionateScreenWidth(10)),

        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.7,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10),
            itemCount: productProvider.products.length,
            itemBuilder: (BuildContext ctx, index) {
              //for (int i=0; i<=productProvider.products.length;i++){
                if (productProvider.products[index].isFavourite) {
                  return ProductCard(product: productProvider.products[index]);
                   }else{

                   return SizedBox
                       .shrink();

                }
            }

            ),

      ),

    );
  }

}
