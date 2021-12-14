import 'package:flutter/material.dart';
import 'package:shop_app/helper/FavoriteHelper.dart';
import 'package:shop_app/helper/OrderHelper.dart';
import 'package:shop_app/helper/UserHelper.dart';
import 'package:shop_app/models/Favorite.dart';
import 'package:shop_app/models/Order.dart';
import 'package:shop_app/models/User.dart';
import '../helper/ProductHelper.dart';
import '../models/Product.dart';

class UserProvider with ChangeNotifier{

  UserHelper _ordHelper = UserHelper();
  List<UserModel> users= [];

  UserProvider.initialize(){
    _loadProduct();
  }

  _loadProduct() async{
    users = await _ordHelper.getOrder();
    notifyListeners();
  }

}