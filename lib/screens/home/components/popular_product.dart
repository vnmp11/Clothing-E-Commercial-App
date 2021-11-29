// import 'package:flutter/material.dart';
// import 'package:shop_app/components/product_card.dart';
// import 'package:shop_app/models/Product.dart';
// import 'package:shop_app/screens/products/products.dart';
//
// import '../../../size_config.dart';
// import 'section_title.dart';
//
// class PopularProducts extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding:
//               EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//           child: SectionTitle(title: "Popular Products", press: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(title: 'Popular Product', product: demoProducts,)));
//           }),
//         ),
//         SizedBox(height: getProportionateScreenWidth(20)),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               ...List.generate(
//                 demoProducts.length,
//                 (index) {
//                   if (demoProducts[index].isPopular)
//                     return ProductCard(product: demoProducts[index]);
//
//                   return SizedBox
//                       .shrink(); // here by default width and height is 0
//                 },
//               ),
//               SizedBox(width: getProportionateScreenWidth(20)),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/helper/ProductHelper.dart';
import 'package:shop_app/screens/products/products.dart';


import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  //@override
  _PopularProductsState createState() => _PopularProductsState();
}
class _PopularProductsState extends State<PopularProducts>{
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<Product> pro = [];
    for(int i=0;i<productProvider.products.length;i++){
      if (productProvider.products[i].isPopular)
        pro.add(productProvider.products[i]);
    }

    return Column(
        children: [

          Padding(
            padding:

            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SectionTitle(title: "Popular Products", press: () {


              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(title: 'Popular Product', product: pro,)));
            }),

          ),

          SizedBox(height: getProportionateScreenWidth(20)),
          SingleChildScrollView(

            scrollDirection: Axis.horizontal, //ngang
            child: Row(
              children: [

                ...List.generate(
                  productProvider.products.length,
                      (index) {
                    if (productProvider.products[index].isPopular)
                      //testProvider.tests.length;

                      return ProductCard(product: productProvider.products[index]);
                    return SizedBox
                        .shrink(); // here by default width and height is 0
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
              ],

            ),
          )

        ]
    );


  }

}

