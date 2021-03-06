import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/cart/components/address.dart';
import 'package:shop_app/screens/detail_order/detail_order.dart';
import 'package:shop_app/screens/details_product/details_screen.dart';
import 'package:shop_app/screens/edit_profile/edit_profile.dart';
import 'package:shop_app/screens/favorite/favorite.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/membership/membership.dart';
import 'package:shop_app/screens/order/order.dart';
import 'package:shop_app/screens/payment/payment.dart';
import 'package:shop_app/screens/products/products.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/screens/success/success.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  EditProfile.routeName: (context) => EditProfile(),
  MyOrder.routeName: (context) => MyOrder(),
  FavoriteScreen.routeName: (context) => FavoriteScreen(),
  MembershipScreen.routeName: (context) => MembershipScreen(),
  DeliveryAddress.routeName: (context) => DeliveryAddress("1"),
  ProductScreen.routeName: (context) => ProductScreen(title: '',product: [],),
  SuccessScreen.routeName: (context) => SuccessScreen(),
  PaymentScreen.routeName: (context) => PaymentScreen(),
  DetailOrder.routeName: (context) => DetailOrder("1"),


};
