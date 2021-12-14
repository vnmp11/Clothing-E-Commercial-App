import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/models/User.dart';

class UserHelper {
  String collection = "Users";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getOrder() async =>
      firestore.collection(collection).get().then((result) {
        List <UserModel> users = [];
        for(DocumentSnapshot order in result.docs){
          users.add(UserModel.fromSnapshot(order));
        }
        return users;
      });
}