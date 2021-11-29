import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/Cart.dart';

class CartHelper {
  String collection = "Cart";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Cart>> getCart() async =>
      firestore.collection(collection).get().then((result) {
        List <Cart> carts= [];
        for(DocumentSnapshot cart in result.docs){
          carts.add(Cart.fromSnapshot(cart));
          print(carts[0].proID);
          print ("work helper");
  }
        return carts;
  });
}