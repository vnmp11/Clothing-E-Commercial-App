import 'package:flutter/material.dart';
import 'package:shop_app/models/Review.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../constants.dart';

class ReviewCard extends StatelessWidget {
  final Function onTap;
  final bool isLess;
  final ReviewModel review;

  ReviewCard({
     Key? key,
    required this.review, required this.onTap, required this.isLess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("image: "+review.image);

    return Container(
      padding: EdgeInsets.only(
        top: 2.0,
        bottom: 2.0,
        left: 16.0,
        right: 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            width: 35,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                ClipOval(
                  child: review.image.isEmpty ? Image.asset("assets/images/avatar.png") : Image.network(review.image, fit: BoxFit.cover)
                ),
              ],
            ),

          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  review.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                review.date,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: kFixPadding),
              Align(
                alignment: Alignment.centerRight,
                child:
                SmoothStarRating(
                  isReadOnly: true,
                  starCount: 5,
                  rating: review.rating,
                  size: 20.0,
                  color:  Color(0xFFFFC416),
                  borderColor:  Color(0xFFFFC416),
                ),)

            ],
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: (){},
            child: isLess
                ? Text(
              review.comment,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: kSecondaryColor,
                    ),
                  )
                : Text(
              review.comment,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: kLightColor,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
