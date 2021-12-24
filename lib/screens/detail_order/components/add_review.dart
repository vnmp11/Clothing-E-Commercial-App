import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/emptySection.dart';
import 'package:shop_app/components/headerLabel.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Review.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/provider/review_provider.dart';
import 'package:shop_app/screens/review/defaultAppBar.dart';
import 'package:shop_app/screens/review/defaultBackButton.dart';
import 'package:shop_app/screens/success/success.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../size_config.dart';


class AddReviewScreen extends StatefulWidget {
  static String routeName = "/payment";

  String id;
  String name;

  AddReviewScreen({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  TextEditingController reviewcontroller = new TextEditingController();
  String review = " ";
  double? rate = 1;
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = <XFile>[];
  File? _image = null;
  String? _downloadUrl = " ";
  List<String> photoUrl = [];
  List<String> photolist = [];

  String? uploadedPhoto = " ";
  bool check = false;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();

    Reference _reference = FirebaseStorage.instance.ref().child("ImageProfile/${user!.uid}");
    _reference.getDownloadURL().then((loc) => setState(() => _downloadUrl = loc));
    if (_downloadUrl == null){
      _downloadUrl = "http://hethongxephangtudong.net/public/client/images/no-avatar.png";
    }
  }


  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);

    showDeleteDialog (BuildContext context, List<String> photoList, bool check){
      AlertDialog alert = AlertDialog(
        content: Text("Are you sure you want to delete images?"),
        actions: <Widget>[

          FlatButton(
            child: new Text("No", style: TextStyle(color: kPrimaryColor),),
            onPressed: () async {
              Navigator.pop(context);
              check = false;
            },
          ),
          FlatButton(
            child: new Text("Yes", style: TextStyle(color: kPrimaryColor),),
            onPressed: () {
              photoList.clear();
              check = true;
              Fluttertoast.showToast(msg: "Deleted successfully.");
              Navigator.pop(context);
              print("check dialog  "+ check.toString());

            },
          ),

        ],
      );
      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    }


    // getting dp URL link
    getUploadedPic(String index,  String datetime) async {

      uploadedPhoto = await FirebaseStorage.instance
          .ref('ImageReview/${widget.id}_${widget.name}_${index}_${datetime}')
          .getDownloadURL();

      photoUrl.add(uploadedPhoto!);
    }

    //upload image
    uploadPic(File image, String index, String datetime) async {
      print("vao upload:" + image.path);
      var snapshot = await FirebaseStorage.instance.ref()
          .child('ImageReview/${widget.id}_${widget.name}_${index}_${datetime}')
          .putFile(image).whenComplete(() => getUploadedPic(index, datetime));
      // setState(()  {
      // });

    }


    //update rating product
    void updateRating(String idPro) {
      double totalRate = 0;
      List<ReviewModel> reviewPro = [];

      //get list review
      for (int i = 0; i < reviewProvider.reviews.length; i++) {
        if (reviewProvider.reviews[i].idPro == idPro) {
          reviewPro.add(reviewProvider.reviews[i]);
        }
      }

      //get rating
      for (int i = 0; i < reviewPro.length; i++) {
        totalRate += reviewPro[i].rating;
      }

      DocumentReference ref1 = FirebaseFirestore.instance.collection('product')
          .doc(idPro);
      ref1.update({
        "rating": totalRate/reviewPro.length,
      });
    }

    //select image from gallery
    Future<void> selectImages() async {
      if (imageFileList!.length == 3)
        {
          Fluttertoast.showToast(msg: "You can only choose 3 images.");
        }else{
        final List<XFile>? selectedImages = await
        imagePicker.pickMultiImage();
        if (selectedImages!.isNotEmpty) {
          imageFileList!.addAll(selectedImages);
        }

        setState((){
        });
      }

    }
    @override
    customButton(List<String> photo){
      this.photolist = photo;
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: 'Add review',
        child: DefaultBackButton(),
      ),
      body: SingleChildScrollView( child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            Padding(
                padding: EdgeInsets.all(
                    getProportionateScreenHeight(10)),
                child:Column(

                    children: <Widget> [
                      imageFileList!.length == 0 ? SizedBox(height: 1) : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              itemCount: imageFileList!.length,
                              shrinkWrap: true,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                              itemBuilder: (BuildContext context, int index) {

                                if (imageFileList!.length == 1)
                                  {
                                    print("leng:"+index.toString() );

                                    uploadPic(File(imageFileList![0].path),
                                        index.toString(),
                                        DateFormat('dd_MM_yyyy hh_mm_ss')
                                            .format(DateTime.now()).toString());
                                  }else if (imageFileList!.length == 2) {
                                  print("leng2:"+index.toString() );
                                  if (index == 1) {
                                    uploadPic(File(imageFileList![1].path),
                                        index.toString(),
                                        DateFormat('dd_MM_yyyy hh_mm_ss')
                                            .format(DateTime.now()).toString());
                                  }
                                }else if (imageFileList!.length == 3) {
                                  print("leng3:"+index.toString() );

                                  if (index == 2) {
                                    uploadPic(File(imageFileList![2].path),
                                        index.toString(),
                                        DateFormat('dd_MM_yyyy hh_mm_ss')
                                            .format(DateTime.now()).toString());
                                  }
                                }


                                return GestureDetector(
                                    onLongPress: () {
                                      setState(()  {

                                          print("photo: "+ photoUrl.length.toString());
                                          photoUrl.removeAt(0);

                                          print("image length: "+ imageFileList!.length.toString());

                                          imageFileList!.removeAt(0);

                                      });

                                },
                                child:  Image.file(File(imageFileList![index].path),
                                  fit: BoxFit.cover,)
                                );

                              },),),
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     height: 200.0,
                      //     child: Center(
                      //       child: _image == null ? Text("No Image Selected!") : Image.file(_image!),
                      //     ),
                      //   ),
                      // ),
                      RaisedButton.icon(
                        label: Text('Add images',
                          style: TextStyle(color: Colors.white, fontSize: 14),),
                        icon: Icon(Icons.camera_enhance_rounded, color:Colors.white,size: 18,),
                        onPressed: () async {
                          selectImages();
                        },
                        color: kPrimaryColor,
                      ),

                    ])),

            SizedBox(
              height: 2.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding:
                  EdgeInsets.only(right: getProportionateScreenWidth(
                      20)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Rate",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 79, 119, 45),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]
                  ),
                ),
                SmoothStarRating(
                  allowHalfRating: false,
                  starCount: 5,
                  rating: 1,
                  size: 30.0,
                  color: Color(0xFFFFC416),
                  borderColor: Color(0xFFFFC416),
                  onRated: (r) {
                    rate = r;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 3.0,
            ),
            Padding(
              padding: EdgeInsets.all(
                  getProportionateScreenHeight(10)),
              child: TextFormField(
                controller: reviewcontroller,
                onSaved: (newValue) => review = newValue!,
                onChanged: (value) {
                  review = value;
                },
                decoration: InputDecoration(
                  hintText: "Say something about the product",
                  border: InputBorder.none,
                ),
                maxLines: 8,
              ),
            ),

            Padding(
                padding: EdgeInsets.all(
                    getProportionateScreenHeight(10)),
                child: DefaultButton(
                  text: "Add Review",
                  press: ()  {

                    ReviewModel newReview = new ReviewModel();
                    newReview.idPro = widget.id;
                    newReview.name = widget.name;
                    newReview.rating = rate!;
                    newReview.date = DateFormat('dd/MM/yyyy hh:mm')
                        .format(DateTime.now());
                    newReview.image = _downloadUrl!;
                    newReview.photo = photoUrl;
                    newReview.comment = review;

                    DocumentReference ref1 = FirebaseFirestore
                        .instance.collection("Review").doc();
                    ref1.set({
                      'image': _downloadUrl,
                      'idPro': widget.id,
                      'name': widget.name,
                      'rating': rate,
                      'date': DateTime.now(),
                      'comment': review,
                      'photo': photoUrl,

                    });

                    reviewProvider.reviews.add(newReview);
                    updateRating(widget.id);
                    Fluttertoast.showToast(msg: "Thank you about your review!");
                    reviewcontroller.clear();
                    Navigator.pop(context);
                  },
                )
            )

          ],
        ),
      ),)
    );
  }



}

