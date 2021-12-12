import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/components/stickyLabel.dart';
import 'package:shop_app/models/Favorite.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/Review.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/screens/home/components/section_title.dart';
import 'package:shop_app/screens/products/products.dart';
import 'package:shop_app/screens/review/Reviews.dart';
import 'package:shop_app/screens/review/review_card.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import "package:intl/intl.dart";

class ProductDescription extends StatefulWidget {
  ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  Product product;
  GestureTapCallback? pressOnSeeMore;
  bool descTextShowFlag = false;

  User? user = FirebaseAuth.instance.currentUser;
  FavoriteModel favModel = FavoriteModel();

  @override
  _ProductDescriptionState createState()=> _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription>{
  Color _isFav = Color(0xFFDBDEE4);
  Color _backFav = Color(0xFFF5F6F9);
  bool isMore = false;

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
    final productProvider = Provider.of<ProductProvider>(context);
    final favProvider = Provider.of<FavoriteProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
              widget.product.title,
              style: TextStyle(
                  fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500)
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(5)),
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
              NumberFormat.simpleCurrency(locale: 'vi').format(widget.product.price).toString(),
              style: TextStyle(
                  fontSize: 18, color: kPrimaryColor,  fontWeight: FontWeight.w500)
          ),

        ),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            splashColor: Colors.green,
            highlightColor: Colors.blue,
            onTap: (){
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
            padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            width: getProportionateScreenWidth(84),
            decoration: BoxDecoration(
              color: _backFav,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            
            child: SvgPicture.asset(
              "assets/icons/Heart Icon_2.svg",
              color: _isFav,
              height: getProportionateScreenWidth(16),
            ),
          ),
          )
        ),
        Padding(
          padding:
          EdgeInsets.only(left: getProportionateScreenWidth(20), right: getProportionateScreenWidth(20),bottom: getProportionateScreenWidth(0)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Color.fromARGB(255, 79, 119, 45),
                  ),
                ),]
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(20), right: getProportionateScreenWidth(20), top: getProportionateScreenWidth(8),bottom: getProportionateScreenWidth(20)),
            child: new Container(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.product.description.replaceAll("\\\\n", "\n"),
                      maxLines: widget.descTextShowFlag ? 20 : 5,textAlign: TextAlign.start, style: TextStyle(fontSize: 14),),
                  InkWell(
                    onTap: (){
                      setState(() {
                        widget.descTextShowFlag = !widget.descTextShowFlag;
                      }); },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        widget.descTextShowFlag ? Text("Show Less",style: TextStyle(color: kPrimaryColor),) :  Text("Show More",style: TextStyle(color: kPrimaryColor))
                      ],
                    ),
                  ),
                ],
              ),

            )

        ),
        Divider(
          thickness: 5.0,
          color: kAccentColor,
        ),

        Padding(
          padding:
          EdgeInsets.only(left: getProportionateScreenWidth(20), right: getProportionateScreenWidth(20),bottom: getProportionateScreenWidth(0)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Reviews",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    color: Color.fromARGB(255, 79, 119, 45),
                  ),
                ),]
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(getProportionateScreenWidth(15)),
          itemCount: 3,
          itemBuilder: (context, index) {
            return ReviewCard(
              image: reviewList[index].image,
              name: reviewList[index].name,
              date: reviewList[index].date,
              comment: reviewList[index].comment,
              rating: reviewList[index].rating,
              onPressed: () => print("More Action $index"),
              onTap: () => setState(() {
                isMore = !isMore;
              }),
              isLess: isMore,
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 2.0,
              color: kAccentColor,
            );
          },
        ),

        Padding(
          padding:

          EdgeInsets.all(getProportionateScreenWidth(15)),
          child: Align(child: GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Reviews()));
            },
            child: Text(
                "See More",
                style: TextStyle(color: Color.fromARGB(255, 125, 133, 151))
            ),
          ),
          alignment: Alignment.center,),

        ),

        Divider(
        color: kAccentColor,
        thickness: 5.0,
        ),

        Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Padding(
                padding:
                EdgeInsets.only(left: getProportionateScreenWidth(20)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Related Product",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          color: Color.fromARGB(255, 79, 119, 45),
                        ),
                      ),]
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              SingleChildScrollView(

                scrollDirection: Axis.horizontal, //ngang
                child: Row(
                  children: [
                    ...List.generate(
                      productProvider.products.length,
                          (index) {
                        if (productProvider.products[index].kind == widget.product.kind)
                          //testProvider.tests.length;

                          return ProductCard(product: productProvider.products[index]);
                        return Container(width: 0, height: 0);// here by default width and height is 0
                      },
                    ),
                  ],

                ),
              ),

              SizedBox(height: getProportionateScreenWidth(20)),

            ]
        )


      ],
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

