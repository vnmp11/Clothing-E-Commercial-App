import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/models/Favorite.dart';
import 'package:shop_app/models/Product.dart';

class RelatedProductHelper {
  String collection = "product";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? user = FirebaseAuth.instance.currentUser;
  FavoriteModel favModel = FavoriteModel();
  bool check = false;

  Future<List<Product>> getProduct() async =>
      firestore.collection(collection).get().then((result) {
        List <Product> products= [];
        for(DocumentSnapshot product in result.docs){
          products.add(Product.fromSnapshot(product));
        }
        return products;
      });

}