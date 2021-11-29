// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {

  String id ="" ;
  String title = "";
  int kind = 0;
  String description = "";
  List<String> images = [];
  double rating = 0;
  double price = 0;
  bool isFavourite = false;
  bool isPopular = false;
  //
  //
  //
  // Product.fromMap(Map<String, dynamic> data){
  //   description = data['description'];
  //   id = data['id'];
  //   title = data ['title'];
  //   images = data['image'];
  //   rating = data['rating'];
  //   price = data['price'];
  //   isFavourite = data['isFa'];
  //   isPopular = data['isPo'];

  static const ID = "id";
  static const TITLE = "title";
  static const KIND = "kind";
  static const DESCRIPTION = "description";
  static const IMAGE = "image";
  static const RATING = "rating";
  static const PRICE = "price";
  static const ISPO = "isPo";
  static const ISFA = "isFa";


  // String id ;
  // String title;
  // int kind;
  // String  description;
  // List<String> images;
  // double rating ;
  // double price ;
  // bool isFavourite;
  // bool isPopular;

  //getter
  // String get _id => id;
  // String get _title => title;
  // int get _kind => kind;
  // String get _description => description;
  // List<String> get _images => images;
  // double get _rating => rating;
  // double get _price => price;
  // bool get _isFavourite => isFavourite;
  // bool get _isPopular => isPopular;



  Product.fromSnapshot(DocumentSnapshot snapshot){

    id = snapshot.get(ID);
    title = snapshot.get(TITLE);
    kind = snapshot.get(KIND);
    description = snapshot.get(DESCRIPTION);
    for(int i=0; i< 3; i++){
      images.add(snapshot.get(IMAGE)[i]) ;
    }

    rating = double.parse(snapshot.get(RATING).toString());
    price = double.parse(snapshot.get(PRICE).toString());
    isFavourite = snapshot.get(ISFA);
    isPopular = snapshot.get(ISPO);

  }

}
