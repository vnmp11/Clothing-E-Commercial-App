
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/emptySection.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/components/subTitle.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/payment/payment.dart';
import 'package:shop_app/screens/review/defaultAppBar.dart';
import 'package:shop_app/screens/review/defaultBackButton.dart';
import 'package:shop_app/screens/success/success.dart';
import 'package:shop_app/size_config.dart';



class DeliveryAddress extends StatefulWidget {
  static String routeName = "/deliveryaddress";

  DeliveryAddress(String this.id, {Key? key}) : super(key: key);
  String id;

  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  TextEditingController addresscontroller = new TextEditingController();
  final List<String?> errors = [];
  String? address;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position? _currentPosition;
  String? _currentAddress;
  LatLng? _center ;
  Position? currentLocation;

  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance.collection("Users").doc(user!.uid)
        .get().then((value){
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        addresscontroller.text = "${loggedInUser.Address}";
      });
    });
  }

  _getLocation() async
  {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    addresscontroller.text = "${first.featureName} : ${first.addressLine}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: "Delivery Address",
        child: DefaultBackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              EmptySection(
                emptyImg: 'assets/images/address4.gif',
                emptyMsg: ' Where are your items shipped?',
              ),
            // HeaderLabel(
            //   headerText: "Where are your ordered items shipped?",
            // ),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildAddressFormField(),
            FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(15)),
              InkWell(
                child: Text("Get the current location?", style: TextStyle(fontSize: 16),),
                onTap: (){
                  setState(()  {
                     _getLocation();
                  });
                },
              ),
              SizedBox(height: getProportionateScreenHeight(8)),
              DefaultButton(
              text: "Go to payment",
              press: () =>
              {
                updateAddress(),

                Navigator.popAndPushNamed(context, PaymentScreen.routeName)
              }
            ),
          ],
        ),
      ),
    );
  }

  updateAddress()
  {
    DocumentReference ref = FirebaseFirestore.instance.collection('Order').doc(widget.id);
    ref.update({
    "address" : addresscontroller.text
    });
  }


  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: addresscontroller,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          print("error: "+errors.toString());
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Delivery Address",
        hintText: "Enter your address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
        CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

}
