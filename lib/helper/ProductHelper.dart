import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/Product.dart';

class ProductHelper {
  String collection = "product";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Product>> getProduct() async =>
      firestore.collection(collection).get().then((result) {
        List <Product> products= [];
        for(DocumentSnapshot product in result.docs){
          products.add(Product.fromSnapshot(product));
          print ("ok");
          print(products[0].id);
  }
        return products;
  });
}