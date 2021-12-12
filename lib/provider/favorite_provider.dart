import 'package:flutter/material.dart';
import 'package:shop_app/helper/FavoriteHelper.dart';
import 'package:shop_app/models/Favorite.dart';
import '../helper/ProductHelper.dart';
import '../models/Product.dart';

class FavoriteProvider with ChangeNotifier{

  FavoriteHelper _favHelper = FavoriteHelper();
  List<Product> products= [];

  FavoriteProvider.initialize(){
    _loadProduct();
  }

  addNewFav(Product pro) async{
    products.add(pro);
    notifyListeners();
  }

  deleteFav(Product pro) async{
    products.remove(pro);
    notifyListeners();
  }

  _loadProduct() async{
    products = await _favHelper.getFavProduct();
    notifyListeners();
  }

}