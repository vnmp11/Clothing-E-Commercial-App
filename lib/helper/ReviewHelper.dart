import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Review.dart';

class ReviewHelper {
  String collection = "Review";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<ReviewModel>> getReview() async =>
      firestore.collection(collection).get().then((result) {
        List <ReviewModel> reviews= [];
        for(DocumentSnapshot cart in result.docs){
          reviews.add(ReviewModel.fromSnapshot(cart));
        }
        return reviews;
      });
}