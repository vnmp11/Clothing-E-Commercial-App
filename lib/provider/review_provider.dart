import 'package:flutter/material.dart';
import 'package:shop_app/helper/FavoriteHelper.dart';
import 'package:shop_app/helper/OrderHelper.dart';
import 'package:shop_app/helper/ReviewHelper.dart';
import 'package:shop_app/helper/UserHelper.dart';
import 'package:shop_app/models/Favorite.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/models/Review.dart';
import 'package:shop_app/models/User.dart';
import '../helper/ProductHelper.dart';
import '../models/Product.dart';

class ReviewProvider with ChangeNotifier{

  ReviewHelper _reviewHelperHelper = ReviewHelper();
  List<ReviewModel> reviews= [];

  ReviewProvider.initialize(){
    _loadProduct();
  }

  _loadProduct() async{
    reviews = await _reviewHelperHelper.getReview();
    notifyListeners();
  }

}