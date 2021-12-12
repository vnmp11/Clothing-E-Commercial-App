import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/favorite_card.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/screens/search/search_service.dart';
import 'package:shop_app/size_config.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List <Product> queryResultSet = [];
  List <Product> tempSearchStore = [];
  TextEditingController _searchcontroller = new TextEditingController();

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((result) {
        for(DocumentSnapshot product in result.docs){
          queryResultSet.add(Product.fromSnapshot(product));
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element.title.startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }

    print("temp: "+tempSearchStore.length.toString());
    print("quety: "+queryResultSet.length.toString());

  }

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<ProductProvider>(context);

    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: kPrimaryColor
        ),
        titleSpacing: 0,
        // The search area here
          title:  Padding(padding: EdgeInsets.only(top: getProportionateScreenWidth(30), bottom: getProportionateScreenWidth(20), right: getProportionateScreenWidth(20)),
              child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFDDE5B6).withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child:
             TextField(
               onChanged: (val) {
                 initiateSearch(val);
               },
               autofocus: true,
                controller: _searchcontroller,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear, color: kPrimaryColor,),
                      onPressed: () {
                        _searchcontroller.clear();
                      },
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                        vertical: getProportionateScreenWidth(9)),
                    border: InputBorder.none,
                    focusColor:Color(0xFF4f772d) ,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Search ...",
                    prefixIcon: Icon(Icons.search, color: Color(0xFF4f772d),)),
              ),

          )),),
          body: Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: ListView.builder(
              itemCount: queryResultSet.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                child: tempSearchStore.isEmpty == true ? null : FavoriteCard(product: tempSearchStore[index],),
              ),
            ),
          ),
    );
  }
}

  Widget buildResultCard(data) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
          child: Center(
              child: Text(data()['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              )
          )
      )
  );
}