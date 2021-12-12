import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Favorite.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/screens/details_product/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';
import "package:intl/intl.dart";


class FavoriteCard extends StatefulWidget {
  FavoriteCard({
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
  _FavoriteCardState createState()=> _FavoriteCardState();
}
class _FavoriteCardState extends State<FavoriteCard>{

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

    return GestureDetector(
        onTap: () => Navigator.pushNamed(
      context,
      DetailsScreen.routeName,
      arguments: ProductDetailsArguments(product: widget.product),
        ),
    child: Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(widget.product.images[0]),
            ),
          ),
        ),
        SizedBox(width: 20),
        Flexible(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.title,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 5),
            Text.rich(
              TextSpan(
                text: NumberFormat.simpleCurrency(locale: 'vi').format(widget.product.price).toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
            ),
            Align(alignment: Alignment.centerRight,
            child:
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
                padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                height: getProportionateScreenWidth(28),
                width: getProportionateScreenWidth(28),
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
            )

          ],
        ))
      ],
    ));
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
