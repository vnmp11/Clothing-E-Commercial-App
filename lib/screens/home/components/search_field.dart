import 'package:flutter/material.dart';
import 'package:shop_app/screens/search/search.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: Color(0xFFDDE5B6).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        readOnly: true,
        onChanged: (value) => print(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusColor:Color(0xFF4f772d) ,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: Icon(Icons.search, color: Color(0xFF4f772d),)),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      ),
    );
  }
}
