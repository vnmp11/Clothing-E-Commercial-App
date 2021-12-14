
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Order {
  String id = " ";
  String uId = " ";
  double totalPrice = 0;
  double subTotal = 0;
  double feeShip  = 0;
  double discount = 0;
  int totalItem = 0;
  String date = " ";
  int status = 1;

  Order(){

  }



  Order.fromSnapshot(DocumentSnapshot snapshot){

    id = snapshot.get("billID");
    uId = snapshot.get("uID");
    totalItem = int.parse(snapshot.get("totalItem").toString());
    totalPrice = double.parse(snapshot.get("totalPrice").toString());
    discount = double.parse(snapshot.get("discount").toString());
    subTotal = double.parse(snapshot.get("subTotal").toString());
    feeShip = double.parse(snapshot.get("feeShip").toString());
    date = formatTimestamp(snapshot.get("date"));
    status = snapshot.get("status");
  }


}

String formatTimestamp(Timestamp timestamp) {
  var format = new DateFormat('dd/MM/yyyy hh:mm'); // 'hh:mm' for hour & min
  return format.format(timestamp.toDate());
}
