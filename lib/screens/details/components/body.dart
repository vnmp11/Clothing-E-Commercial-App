import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
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

class Body extends StatelessWidget {
  final Product product;
  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var document =  FirebaseFirestore.instance.collection('Cart').doc();
    var documentUuid = document.id;

    final cartProvider = Provider.of<CartProvider>(context);
    Cart cartadd = Cart();
    cartadd.price =product.price;
    cartadd.name= product.title;
    cartadd.proID= product.id;
    cartadd.image= product.images[0];
    cartadd.status = false;
    //chua co gia tri
    User? user = FirebaseAuth.instance.currentUser;
    cartadd.uID= user!.uid ;
    final _auth= FirebaseAuth.instance;

    //cartadd.cartID = documentUuid;
    cartadd.numOfItem = 1;

bool test =false;
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(20),
                          top: getProportionateScreenWidth(5),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {

                            for(int i = 0;i<cartProvider.carts.length;i++){

                              if((cartProvider.carts[i].uID == user.uid) && (cartProvider.carts[i].proID == product.id) && (cartProvider.carts[i].status == false) ){
                                DocumentReference ref = FirebaseFirestore.instance.collection("Cart").doc(cartProvider.carts[i].cartID);
                                ref.update({
                                  'numOfItem':cartProvider.carts[i].numOfItem + 1,
                                });

                                cartProvider.carts[i].numOfItem +=1;
                                test =true;

                              }
                            }
                            if(test == false){
                              DocumentReference ref1 = FirebaseFirestore.instance.collection("Cart").doc();
                                ref1.set({
                                  'image': product.images[0],
                                  'name':product.title,
                                  'numOfItem':1,
                                  'price':product.price,
                                  'proID':product.id,
                                  'status':false,
                                  'uID':user.uid,
                                  "cartID": ref1.id,
                                });
                                cartadd.cartID = ref1.id;
                                cartProvider.carts.add(cartadd);
                            }

                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
