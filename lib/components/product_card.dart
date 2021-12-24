import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Favorite.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/Review.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/provider/review_provider.dart';
import 'package:shop_app/screens/details_product/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';
import "package:intl/intl.dart";


class ProductCard extends StatefulWidget {
  ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;

  User? user = FirebaseAuth.instance.currentUser;
  FavoriteModel favModel = FavoriteModel();

  @override
  _ProductCardState createState()=> _ProductCardState();
}
class _ProductCardState extends State<ProductCard>{

  Color _isFav = Color(0xFFDBDEE4);
  Color _backFav = Color(0xFFF5F6F9);

  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection("Users").doc(widget.user!.uid).collection("favorite").doc(widget.product.id)
        .get().then((value){
          if (value.exists) {
            this.widget.favModel = FavoriteModel.fromMap(value.data());
            setState(() {
              if ("${widget.favModel.isFav}" == "true") {
                widget.product.isFavourite = true;
                _isFav = Color(0xFFFF4848);
                _backFav = Color(0xFFFFE6E6);
              }
            });
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);
    final reviewProvider = Provider.of<ReviewProvider>(context);

    List<ReviewModel> reviewPro = [];
    double totalRate = 0;


    //get list review
    for (int i = 0;i < reviewProvider.reviews.length ; i++){
      if (reviewProvider.reviews[i].idPro == widget.product.id){
        reviewPro.add(reviewProvider.reviews[i]);
      }
    }

    //get rating
    for (int i = 0; i< reviewPro.length; i++) {
      totalRate += reviewPro[i].rating;
    }

    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20), right: getProportionateScreenWidth(5), bottom: getProportionateScreenWidth(5)),
      child: SizedBox(
        width: getProportionateScreenWidth(widget.width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: widget.product),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: widget.product.id.toString(),
                    child: Image.network(widget.product.images[0]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.title,
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w600),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    NumberFormat.simpleCurrency(locale: 'vi').format(widget.product.price).toString(),
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      fontWeight: FontWeight.w400,
                      color: kPrimaryColor,
                    ),
                  ),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  Text(
                    totalRate == 0 ? "5.0" : NumberFormat("0.#").format(totalRate/reviewPro.length).toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset("assets/icons/Star Icon.svg"),]),

                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      setState(() {
                        if (_isFav == Color(0xFFDBDEE4)) {
                          _isFav = Color(0xFFFF4848);
                          _backFav = Color(0xFFFFE6E6);

                          addFav(widget.product);
                          favProvider.products.add(widget.product);
                        }
                        else if (_isFav == Color(0xFFFF4848)) {
                          _isFav = Color(0xFFDBDEE4);
                          _backFav = Color(0xFFF5F6F9);

                          removeFav(widget.product);
                          favProvider.products.remove(widget.product);
                        }
                      });

                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                      height: getProportionateScreenWidth(25),
                      width: getProportionateScreenWidth(25),
                      decoration: BoxDecoration(
                        color: _backFav,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: _isFav
                      ),
                    ),

                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}

void addFav(Product product)
{
  User? user = FirebaseAuth.instance.currentUser;

  List yourFavList = [];
  yourFavList.add({
    "idPro": product.id,
  });
  //
  // DocumentReference ref1 = FirebaseFirestore.instance.collection("Users").doc(user!.uid);
  // ref1.update({
  //   "listFav": FieldValue.arrayUnion(yourFavList),
  // });

  // FirebaseFirestore.instance.collection("Users").doc(user!.uid).collection("favorite").doc(product.id).set({"isFav":"true"});
  // FirebaseFirestore.instance.collection("product").doc(product.id).update({"isFa":true});
  DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(user!.uid).collection("favorite").doc(product.id);
  ref.set({
    'id':product.id,
    'title':product.title,
    'image':product.images,
    'price':product.price,
    'isFa': true,
    'kind': product.kind,
    'isPo': product.isPopular,
    'rating': product.rating,
    'description': product.description
  });

}

void removeFav(Product product)
{
   User? user = FirebaseAuth.instance.currentUser;
  // FirebaseFirestore.instance.collection("Users").doc(user!.uid).collection("favorite").doc(product.id).set({"isFav":"false"});
  // FirebaseFirestore.instance.collection("product").doc(product.id).update({"isFa":false});
  DocumentReference ref = FirebaseFirestore.instance.collection("Users").doc(user!.uid).collection("favorite").doc(product.id);
  ref.update({
    'isFa': false,
  });
}
