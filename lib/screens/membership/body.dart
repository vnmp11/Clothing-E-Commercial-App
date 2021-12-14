// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shop_app/components/dialog.dart';
// import 'package:shop_app/components/product_card.dart';
// import 'package:shop_app/models/Product.dart';
// import 'package:shop_app/screens/edit_profile/edit_profile.dart';
// import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
//
// import '../../../constants.dart';
// import '../../size_config.dart';
//
//
// class Body extends StatelessWidget {
//   late SharedPreferences prefs;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(getProportionateScreenWidth(10)),
//         child: GridView.builder(
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 200,
//                 childAspectRatio: 0.7,
//                 crossAxisSpacing: 5,
//                 mainAxisSpacing: 10),
//             itemCount: demoProducts.length,
//             itemBuilder: (BuildContext ctx, index) {
//               return ProductCard(product: demoProducts[index]);
//             }),
//       ),
//     );
//   }
//
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/dialog.dart';
import 'package:shop_app/components/favorite_card.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/components/top_rounded_container.dart';
import 'package:shop_app/models/Favorite.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/screens/edit_profile/edit_profile.dart';
import 'package:shop_app/screens/profile/components/profile_pic.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import '../../../constants.dart';
import '../../size_config.dart';


class Body extends StatefulWidget {

  _BodyState createState() => _BodyState();
}
class _BodyState extends State<Body>{
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? _downloadUrl = "http://hethongxephangtudong.net/public/client/images/no-avatar.png";
  String? name = " ";
  String? email = " ";
  double point = 0;
  double missingPoint = 0;
  double totalPoint = 3000000;
  String? member = "Copper";
  Color labelMember = Color(0xFFB05E27);

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("Users").doc(user!.uid)
        .get().then((value){
      this.loggedInUser = UserModel.fromMap(value.data());

      setState(() {
        email = loggedInUser.Email!;
        name = loggedInUser.Name!;
        point = loggedInUser.Point!;

        if (point >= 10000000){
          member = "Diamond";
          totalPoint = 100000000;
          labelMember = Color(0xFF98c1d9);
        }else if (point >= 5000000)
          {
            member = "Gold";
            totalPoint = 10000000;
            labelMember = Color(0xFFffd60a);
          }
        else if (point >= 3000000)
        {
          member = "Silver";
          totalPoint = 5000000;
          labelMember = Color(0xFFadb5bd);
        }

      });
    });



    Reference _reference = FirebaseStorage.instance.ref().child("ImageProfile/${user!.uid}");
    _reference.getDownloadURL().then((loc) => setState(() => _downloadUrl = loc));
    if (_downloadUrl == null){
      _downloadUrl = "http://hethongxephangtudong.net/public/client/images/no-avatar.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        body: SizedBox(
      width: double.infinity,
      child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child:  Container(
                  height: 270.0,
                  child: Lottie.asset('assets/images/trophy.json',
                    height: getProportionateScreenHeight(665),
                    width: getProportionateScreenWidth(635),
                    repeat: true,
                  )),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.all(getProportionateScreenWidth(15)),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Total point: ',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, color: kPrimaryColor, fontSize: 16)),
                        TextSpan(
                            text: NumberFormat.decimalPattern().format(point).toString(),
                            style: TextStyle(fontSize: 16,
                                color: kPrimaryColor)),
                      ]),
                    ),
                  ),
            Align(alignment: Alignment.center, child:
            LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              lineHeight: 6.0,
              // linearStrokeCap: LinearStrokeCap.roundAll,
              width: 200,
              animation: true,
              animationDuration: 2500,
              percent: point/totalPoint,
              progressColor: kPrimaryColor,
            )
            ),
                  SizedBox(height: getProportionateScreenWidth(10)),

                  RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Gain ',style: TextStyle(fontSize: 16, color: kSecondaryColor)),
                TextSpan(
                    text: NumberFormat.decimalPattern().format(totalPoint-point).toString(),
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.w600, fontSize: 16)),
                TextSpan(
                  text: ' points to be upgraded! ',style: TextStyle(fontSize: 16, color: kSecondaryColor)),
              ]),
            ),
            ]),
            Spacer(),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TopRoundedContainer(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              ClipOval(
                                child: (_downloadUrl != null)?Image.network(_downloadUrl!, fit: BoxFit.cover) : Image.asset(
                                  'assets/images/avatar.png',
                                  fit: BoxFit.cover,
                                  height: 150.0,
                                  width: 100.0,
                                ),
                              ),
                            ],
                          ),

                        ),

                        SizedBox(height: getProportionateScreenWidth(10)),
                        Text(
                          "${member}"+" Member",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: labelMember, fontSize: 20, fontWeight: FontWeight.w600 ),
                        ),
                        SizedBox(height: getProportionateScreenWidth(5)),
                        Text(
                         name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kPrimaryColor, fontSize: 16, fontWeight: FontWeight.w500 ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(bottom: getProportionateScreenWidth(30), top: getProportionateScreenWidth(2)),
                          child: Text(
                              email!,
                              style: TextStyle(
                                  fontSize: 16, color: kPrimaryColor, fontWeight: FontWeight.w500)
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
            )
            ]
        )
        )
    );
  }
}
