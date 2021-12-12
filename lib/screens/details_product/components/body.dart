import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/screens/details_product/components/add_to_cart_card.dart';
import 'package:shop_app/size_config.dart';

import 'product_description.dart';
import '../../../components/top_rounded_container.dart';
import 'product_images.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  final Product product;
  int numOfItems = 1;
  Body({Key? key, required this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  @override
  Widget build(BuildContext context) {

    var document =  FirebaseFirestore.instance.collection('Cart').doc();
    var documentUuid = document.id;


    final cartProvider = Provider.of<CartProvider>(context);
    Cart cartadd = Cart();
    cartadd.price = widget.product.price;
    cartadd.name= widget.product.title;
    cartadd.proID= widget.product.id;
    cartadd.image= widget.product.images[0];
    cartadd.status = false;
    //chua co gia tri
    User? user = FirebaseAuth.instance.currentUser;
    cartadd.uID= user!.uid ;
    final _auth= FirebaseAuth.instance;

    //cartadd.cartID = documentUuid;
    cartadd.numOfItem = widget.numOfItems;

    bool test =false;
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
