import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../helper/ProductHelper.dart';
import '../models/Product.dart';
import 'Product.dart';
import 'Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String image = "";
  String name = "";
  double price = 0;

  //int quantity=0;
  String proID = "";
  String uID = "";
  int numOfItem = 0;
  String cartID = "";
  bool status = false;
  
Cart(){

}
  Cart.fromSnapshot(DocumentSnapshot snapshot){

    image = snapshot.get("image");
    name = snapshot.get("name");
    price = double.parse(snapshot.get("price").toString());
    //quantity = snapshot.get(DESCRIPTION);
    proID = snapshot.get("proID");
    uID = snapshot.get("uID");
    cartID =snapshot.get("cartID");
    numOfItem = snapshot.get("numOfItem");
    status = snapshot.get("status");
  }

  Map<String, dynamic> toMap()
  {
    return {
      'uID':uID,
      'name':name,
      'image':image,
      'price':price,
      'proID':proID,
      'status' : status,
      'numOfItem' : numOfItem,
    };
  }
}
