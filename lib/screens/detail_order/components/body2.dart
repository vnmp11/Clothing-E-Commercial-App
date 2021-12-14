import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/dialog.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/Review.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/review_provider.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/cart/components/cart_card.dart';
import 'package:shop_app/screens/cart/components/check_out_card.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

TextEditingController reviewcontroller = new TextEditingController();
String? review;
double? rate = 1;
var reviewProvider;

class DeliveredBody extends StatefulWidget {
  DeliveredBody(String this.id, {Key? key}) : super(key: key);
  String id;

  @override
  _DeliveredBodyState createState() => _DeliveredBodyState();
}

class _DeliveredBodyState extends State<DeliveredBody> {
  List <Cart> cart = [];
  List lcart = [];
  String? name;
  String? _downloadUrl = " ";

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  Future<List> fetchAllContact() async {
    List listCart = [];
    DocumentSnapshot documentSnapshot =
    await FirebaseFirestore.instance.collection('Order').doc(widget.id).get();
    listCart = documentSnapshot['listCart'];
    return listCart;
  }


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("Users").doc(user!.uid)
        .get().then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        name = "${loggedInUser.Name}";
      });
    });

    fetchAllContact().then((List list) {
      setState(() {
        lcart = list;
      });
    });

    Reference _reference = FirebaseStorage.instance.ref().child("ImageProfile/${user!.uid}");
    _reference.getDownloadURL().then((loc) => setState(() => _downloadUrl = loc));
    if (_downloadUrl == null){
      _downloadUrl = "http://hethongxephangtudong.net/public/client/images/no-avatar.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> cartList = [];
    reviewProvider = Provider.of<ReviewProvider>(context);

    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: lcart.length,
        itemBuilder: (context, index) =>
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(onTap: () =>
                    openAlertBox(context, lcart[index]['proID'], name!),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 88,
                        child: AspectRatio(
                          aspectRatio: 0.88,
                          child: Container(
                            padding: EdgeInsets.all(
                                getProportionateScreenWidth(20)),
                            decoration: BoxDecoration(
                              color: Color(0xFFDDE5B6).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.network(lcart[index]['image']),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Flexible(child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lcart[index]['name'],
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            maxLines: 2,
                          ),
                          SizedBox(height: 5),
                          Text.rich(
                            TextSpan(
                              text: NumberFormat.simpleCurrency(locale: 'vi')
                                  .format(lcart[index]['price'])
                                  .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        "x${lcart[index]['numOfItem']}",
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText1),
                                    IconButton(
                                      onPressed: () {
                                        openAlertBox(
                                            context, lcart[index]['proID'],
                                            name!);
                                      },
                                      icon: Icon(
                                        Icons.rate_review_outlined,
                                        color: kPrimaryColor,
                                      ),
                                      iconSize: 25,),

                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ))
                    ],
                  ),)
            ),
      ),
    );
  }

  void updateRating(String idPro) {
    double totalRate = 0;
    List<ReviewModel> reviewPro = [];

    //get list review
    for (int i = 0; i < reviewProvider.reviews.length; i++) {
      if (reviewProvider.reviews[i].idPro == idPro) {
        reviewPro.add(reviewProvider.reviews[i]);
      }
    }

    //get rating
    for (int i = 0; i < reviewPro.length; i++) {
      totalRate += reviewPro[i].rating;
    }

    DocumentReference ref1 = FirebaseFirestore.instance.collection('product')
        .doc(idPro);
    ref1.update({
      "rating": totalRate/reviewPro.length,
    });
  }


  openAlertBox(BuildContext context, String id, String name) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  width: 400.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding:
                            EdgeInsets.only(right: getProportionateScreenWidth(
                                50)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rate",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 79, 119, 45),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          SmoothStarRating(
                            allowHalfRating: false,
                            starCount: 5,
                            rating: 1,
                            size: 30.0,
                            color: Color(0xFFFFC416),
                            borderColor: Color(0xFFFFC416),
                            onRated: (r) {
                              rate = r;
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            getProportionateScreenHeight(10)),
                        child: TextFormField(
                          controller: reviewcontroller,
                          onSaved: (newValue) => review = newValue,
                          onChanged: (value) {
                            review = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Say something about the product",
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              getProportionateScreenHeight(10)),
                          child: DefaultButton(
                            text: "Add Review",
                            press: () {
                              ReviewModel newReview = new ReviewModel();
                              newReview.idPro = id;
                              newReview.name = name;
                              newReview.rating = rate!;
                              newReview.date = DateFormat('dd/MM/yyyy hh:mm')
                                  .format(DateTime.now());
                              newReview.image = _downloadUrl!;
                              newReview.comment = review!;

                              DocumentReference ref1 = FirebaseFirestore
                                  .instance.collection("Review").doc();
                              ref1.set({
                                'image': _downloadUrl,
                                'idPro': id,
                                'name': name,
                                'rating': rate,
                                'date': DateTime.now(),
                                'comment': review,

                              });

                              reviewProvider.reviews.add(newReview);
                              updateRating(id);

                              reviewcontroller.clear();
                              Navigator.pop(context);
                            },
                          )
                      )

                    ],
                  ),
                ),)
          );
        });
  }

}
