import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shop_app/components/dialog.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({ Key? key}) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {

  User? user = FirebaseAuth.instance.currentUser;
  ImagePicker imagePicker = ImagePicker();
  String? _downloadUrl = "http://hethongxephangtudong.net/public/client/images/no-avatar.png";
  File? imageFile = null;
  late PickedFile pickedFile;

  @override
  void initState() {
    super.initState();
    Reference _reference = FirebaseStorage.instance.ref().child("ImageProfile/${user!.uid}");
    _reference.getDownloadURL().then((loc) => setState(() => _downloadUrl = loc));
    if (_downloadUrl == null){
      _downloadUrl = "http://hethongxephangtudong.net/public/client/images/no-avatar.png";
    }
  }

  Future getImage() async {
    final pickedFile  = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        uploadPic(imageFile!);
      });
    }
  }
  uploadPic(File image) async {
    var snapshot = await FirebaseStorage.instance.ref()
        .child('ImageProfile/${user!.uid}')
        .putFile(image);

    setState(()  {
      MyDialog().showLoaderDialog(context);
      Future.delayed(Duration(seconds: 3));
      Navigator.pop(context);
      MyDialog().showCompleteDialog(context, "Updated your image.");
    });

  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: (_downloadUrl!=null && imageFile==null)?Image.network(_downloadUrl!, fit: BoxFit.cover) : Image.file(
              imageFile!,
              fit: BoxFit.cover,
              height: 150.0,
              width: 100.0,
            ),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  getImage();

                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
