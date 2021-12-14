import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uID;
  String? Name;
  String? Email;
  String? Phone;
  String? Address;
  String? Role;
  double? Point;
  double? Discount;

  UserModel({this.uID, this.Email, this.Name, this.Phone, this.Address, this.Role, this.Point, this.Discount});

  UserModel.fromSnapshot(DocumentSnapshot snapshot){

    uID = snapshot.get("uID");
    Name = snapshot.get("Name");
    Email = snapshot.get("Email");
    Phone = snapshot.get("Phone");
    Address = snapshot.get("Address");
    Role = snapshot.get("Role");
    Point = double.parse(snapshot.get("Point").toString());
    Discount = double.parse(snapshot.get("Discount").toString());
  }

  //get data from server
  factory UserModel.fromMap(map)
  {
    return UserModel(
    uID: map['uID'],
    Name: map['Name'],
    Phone: map['Phone'],
    Email: map['Email'],
    Address: map['Address'],
        Role: map['Role'],
        Point: double.parse(map['Point'].toString()),
      Discount: double.parse(map['Discount'].toString()),

    );
  }

  //send data to server
  Map<String, dynamic> toMap()
  {
    return {
      'uID':uID,
      'Name':Name,
      'Phone':Phone,
      'Email':Email,
      'Address':Address,
      'Role' : Role,
      'Point': Point,
      'Discount' : Discount
    };
  }

}