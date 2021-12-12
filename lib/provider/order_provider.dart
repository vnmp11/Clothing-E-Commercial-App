import 'package:flutter/material.dart';
import 'package:shop_app/helper/FavoriteHelper.dart';
import 'package:shop_app/helper/OrderHelper.dart';
import 'package:shop_app/models/Favorite.dart';
import 'package:shop_app/models/Order.dart';
import '../helper/ProductHelper.dart';
import '../models/Product.dart';

class OrderProvider with ChangeNotifier{

  OrderHelper _ordHelper = OrderHelper();
  List<Order> orders= [];

  OrderProvider.initialize(){
    _loadProduct();
  }

  _loadProduct() async{
    orders = await _ordHelper.getOrder();
    notifyListeners();
  }

}