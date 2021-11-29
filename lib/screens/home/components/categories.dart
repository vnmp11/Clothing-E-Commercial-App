import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/screens/products/products.dart';

import '../../../size_config.dart';

class Categories extends StatefulWidget {
  _CategoriesState createState() => _CategoriesState();
}
class _CategoriesState extends State<Categories>{
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<Product> Cap = [];
    List<Product> Pants = [];
    List<Product> Dress = [];
    List<Product> Tshirt = [];
    List<Product> Jacket = [];

    for (int i=0;i<productProvider.products.length;i++){
      if(productProvider.products[i].kind == 1){
        Cap.add(productProvider.products[i]);
      }else if (productProvider.products[i].kind == 2){
        Pants.add(productProvider.products[i]);
      }else if (productProvider.products[i].kind == 3){
        Dress.add(productProvider.products[i]);
      }else if (productProvider.products[i].kind == 4){
        Tshirt.add(productProvider.products[i]);
      }else if (productProvider.products[i].kind == 5){
        Jacket.add(productProvider.products[i]);
      }
    }
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/cap.svg", "text": "Cap", "kind" : "1"},
      {"icon": "assets/icons/pants.svg", "text": "Pants","kind" : "2"},
      {"icon": "assets/icons/dress.svg", "text": "Dress","kind" : "3"},
      {"icon": "assets/icons/tshirt.svg", "text": "T-shirt", "kind" : "4"},
      {"icon": "assets/icons/jacket.svg", "text": "Jacket", "kind" : "5"},
    ];

    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],

            press: () {

              // Navigator.of(context).push(MaterialPageRoute(builder:
              //     (context) => ProductScreen(title: "${categories[index]["text"]}",
              //       product: productProvider.products,)));

              if (categories[index]["kind"] == "1") {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProductScreen(title: "${categories[index]["text"]}",
                          product:Cap ,)));
              }else if (categories[index]["kind"] == "2")
              {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProductScreen(title: "${categories[index]["text"]}",
                          product: Pants,)));
              }else if (categories[index]["kind"] == "3"){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProductScreen(title: "${categories[index]["text"]}",
                          product: Dress,)));
              }else if (categories[index]["kind"] == "4")
              {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProductScreen(title: "${categories[index]["text"]}",
                          product: Tshirt,)));
              }else{
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProductScreen(title: "${categories[index]["text"]}",
                          product: Jacket,)));
              }
              },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFFDDE5B6).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
