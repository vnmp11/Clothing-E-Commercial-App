import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/models/Favorite.dart';
import 'package:shop_app/models/Product.dart';

class FavoriteHelper {
  String collection = "product";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? user = FirebaseAuth.instance.currentUser;
  FavoriteModel favModel = FavoriteModel();
  bool check = false;

  Future<List<Product>> getFavProduct() async =>
      firestore.collection("Users").doc(user!.uid).collection("favorite").get().then((result) {
        List <Product> products= [];
        List <Product> listFav= [];

        for(DocumentSnapshot product in result.docs){
          products.add(Product.fromSnapshot(product));
        }

        for(int i=0;i<products.length;i++){
          if (products[i].isFavourite == true)
            listFav.add(products[i]);
        }
        return listFav;
      });
}