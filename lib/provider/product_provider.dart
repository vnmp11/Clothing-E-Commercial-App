import 'package:flutter/material.dart';
import '../helper/ProductHelper.dart';
import '../models/Product.dart';

class ProductProvider with ChangeNotifier{

  ProductHelper _productHelper = ProductHelper();
  List<Product> products= [];

  ProductProvider.initialize(){
    _loadProduct();
  }
  _loadProduct() async{
    products = await _productHelper.getProduct();
    notifyListeners();
  }

}