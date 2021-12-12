import 'package:flutter/material.dart';
import 'package:shop_app/helper/RelatedProductHelper.dart';
import '../helper/ProductHelper.dart';
import '../models/Product.dart';

class RelatedProductProvider with ChangeNotifier{

  RelatedProductHelper _productHelper = RelatedProductHelper();
  List<Product> products= [];

  RelatedProductProvider.initialize(){
    _loadProduct();
  }
  _loadProduct() async{
    products = await _productHelper.getProduct();
    notifyListeners();
  }

}