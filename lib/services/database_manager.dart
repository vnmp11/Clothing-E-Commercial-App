import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager{
  final FirebaseFirestore fstore = FirebaseFirestore.instance;

  Future updateDataUser(String Name, String Phone, String Address, String id) async {
      return await fstore.collection("Users").doc(id).update({
        'Name' : Name,
        'Phone':Phone,
        'Address':Address
  });
  }
}