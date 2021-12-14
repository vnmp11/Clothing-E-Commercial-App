
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/Favorite.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/provider/order_provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/provider/related_product_provider.dart';
import 'package:shop_app/provider/review_provider.dart';
import 'package:shop_app/provider/user_provider.dart';

import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';

int? isViewed;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  isViewed = pref.getInt('splashScreen');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: ProductProvider.initialize()),
    ChangeNotifierProvider.value(value: CartProvider.initialize()),
    ChangeNotifierProvider.value(value: FavoriteProvider.initialize()),
    ChangeNotifierProvider.value(value: RelatedProductProvider.initialize()),
    ChangeNotifierProvider.value(value: OrderProvider.initialize()),
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
    ChangeNotifierProvider.value(value: ReviewProvider.initialize()),
  ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NewLOOK',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: isViewed != 0 ? SplashScreen.routeName : HomeScreen.routeName,
      routes: routes,
    ),
  ),
  );
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NewLOOK',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: isViewed != 0 ? SplashScreen.routeName : HomeScreen.routeName,
      routes: routes,
    );
  }
}