import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Order.dart';

class OrderHelper {
  String collection = "Order";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Order>> getOrder() async =>
      firestore.collection(collection).get().then((result) {
        List <Order> orders = [];
        for(DocumentSnapshot order in result.docs){
          orders.add(Order.fromSnapshot(order));
        }
        return orders;
      });
}