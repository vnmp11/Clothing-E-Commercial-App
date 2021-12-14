import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReviewModel {
  String image = " ";
  String idPro = " ";
  String name = " ";
  double rating = 0;
  String date = " ";
  String comment = " ";

  ReviewModel()
  {}

  ReviewModel.fromSnapshot(DocumentSnapshot snapshot) {
    image = snapshot.get('image');
    idPro = snapshot.get('idPro');
    name = snapshot.get('name');
    rating = double.parse(snapshot.get("rating").toString());
    date = formatTimestamp(snapshot.get("date"));
    comment = snapshot.get('comment');
  }

  Map<String, dynamic> toMap() {
    return {
      'image': this.image,
      'idPro': this.idPro,
      'name': this.name,
      'rating': this.rating,
      'date': this.date,
      'comment': this.comment,
    };
  }
}

String formatTimestamp(Timestamp timestamp) {
  var format = new DateFormat('dd/MM/yyyy hh:mm'); // 'hh:mm' for hour & min
  return format.format(timestamp.toDate());
}