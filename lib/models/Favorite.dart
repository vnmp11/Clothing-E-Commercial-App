import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel {
  bool? isFav;
  String id ="" ;
  String title = "";
  double price = 0;
  List<String> images = [];

  FavoriteModel({this.isFav});

  //get data from server
  factory FavoriteModel.fromMap(map)
  {
    return FavoriteModel(
      isFav: map['isFa'],
    );
  }

  //send data to server
  FavoriteModel.fromSnapshot(DocumentSnapshot snapshot){

    id = snapshot.get("uID");
    title = snapshot.get("title");
    for(int i=0; i< 3; i++){
      images.add(snapshot.get("image")[i]) ;
    }
    price = double.parse(snapshot.get("price").toString());
    isFav = snapshot.get("isFav");
  }

  Map<String, dynamic> toMap()
  {
    return {
      'uID':id,
      'title':title,
      'image':images,
      'price':price,
      'isFav':isFav,
    };
  }

}