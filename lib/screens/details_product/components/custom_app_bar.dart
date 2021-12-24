import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/Review.dart';
import 'package:shop_app/provider/review_provider.dart';
import 'package:shop_app/screens/home/home_screen.dart';

import '../../../size_config.dart';

class CustomAppBar extends StatelessWidget {
  final Product product;
  double totalRate = 0;

  CustomAppBar({required this.product});

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);

    List<ReviewModel> reviewPro = [];

    //get list review
    for (int i = 0;i < reviewProvider.reviews.length ; i++){
      if (reviewProvider.reviews[i].idPro == product.id){
        reviewPro.add(reviewProvider.reviews[i]);
      }
    }

    //get rating
    for (int i = 0; i< reviewPro.length; i++) {
      totalRate += reviewPro[i].rating;
    }

    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20), vertical: getProportionateScreenWidth(5)),

        child: Row(
          children: [
            SizedBox(
              height: getProportionateScreenWidth(35),
              width: getProportionateScreenWidth(35),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  primary: kPrimaryColor,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => Navigator.popAndPushNamed(context,HomeScreen.routeName),
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(
                    totalRate == 0 ? "5.0" : NumberFormat("0.#").format(totalRate/reviewPro.length).toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset("assets/icons/Star Icon.svg"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
