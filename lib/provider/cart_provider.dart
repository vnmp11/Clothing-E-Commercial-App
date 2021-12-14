import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import '../helper/CartHelper.dart';
import '../models/Cart.dart';

class CartProvider with ChangeNotifier{

  CartHelper _cartHelper = CartHelper();
  List<Cart> carts= [];


  CartProvider.initialize(){
    _loadCart();

  }
  _loadCart() async{
    carts = await _cartHelper.getCart();
    notifyListeners();
  }


}