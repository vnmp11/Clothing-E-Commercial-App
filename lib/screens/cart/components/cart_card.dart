// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_app/models/Cart.dart';
// import 'package:shop_app/provider/cart_provider.dart';
//
// import '../../../constants.dart';
// import '../../../size_config.dart';
//
// class CartCard extends StatefulWidget {
//   _CartCardState createState() => _CartCardState();
// }
// class _CartCardState extends State<CartCard>{
//
//   const CartCard({
//     Key? key,
//     required this.cart,
//   }) : super(key: key);
//
//   final Cart cart;
//
//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);
//     return Row(
//       children: [
//         SizedBox(
//           width: 88,
//           child: AspectRatio(
//             aspectRatio: 0.88,
//             child: Container(
//               padding: EdgeInsets.all(getProportionateScreenWidth(10)),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF5F6F9),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Image.network(cartProvider.carts[1].image),
//             ),
//           ),
//         ),
//         SizedBox(width: 20),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               //fix
//               cartProvider.carts[0].name,
//               style: TextStyle(color: Colors.black, fontSize: 16),
//               maxLines: 2,
//             ),
//             SizedBox(height: 10),
//             Text.rich(
//               TextSpan(
//                 //fix
//                 text: "\$${cartProvider.carts[0].price}",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600, color: kPrimaryColor),
//                 children: [
//                   TextSpan(
//                       text: " x${cartProvider.carts[0].numOfItem}",
//                       style: Theme.of(context).textTheme.bodyText1),
//                 ],
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/cart/components/check_out_card.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import "package:intl/intl.dart";


class CartCard extends StatefulWidget {
  CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;
  int numOfItems = 1;

  @override
  _CartCardState createState() => _CartCardState();
}
class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(20)),
              decoration: BoxDecoration(
                color: Color(0xFFDDE5B6).withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(widget.cart.image),
            ),
          ),
        ),
        SizedBox(width: 20),
        Flexible(child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
              widget.cart.name,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 5),
            Text.rich(
              TextSpan(
                text: NumberFormat.simpleCurrency(locale: 'vi').format(widget.cart.price).toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (widget.cart
                                  .numOfItem > 0) {
                                widget.cart
                                    .numOfItem--;
                              }
                              Navigator.popAndPushNamed(context,CartScreen.routeName);

                            });
                          },
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: kPrimaryColor,
                          ),
                          iconSize: 22,),
                      Text(
                              "x${widget.cart.numOfItem}",
                              style: Theme.of(context).textTheme.bodyText1),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              // Max 100
                              if (widget.cart
                                  .numOfItem<= 100) {
                                widget.cart
                                    .numOfItem++;
                              }
                              Navigator.popAndPushNamed(context,CartScreen.routeName);
                            });
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: kPrimaryColor,
                          ),
                        iconSize: 22,),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ))
      ],
    );
  }
}
