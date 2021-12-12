import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../constants.dart';

class ReviewCard extends StatelessWidget {
  final String image, name, date, comment;
  final double rating;
  final Function onTap, onPressed;
  final bool isLess;
  const ReviewCard({
     Key? key,
    required this.name,
    required this.image,
    required this.date,
    required this.comment,
    required this.rating,
    required this.onTap,
    required this.isLess,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Container(
            height: 45.0,
            width: 45.0,
            margin: EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/splash1.png",),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(44.0),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
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
                date,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: kFixPadding),
              Align(
                alignment: Alignment.centerRight,
                child:
                SmoothStarRating(
                  isReadOnly: true,
                  starCount: 5,
                  rating: rating,
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
                    comment,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: kSecondaryColor,
                    ),
                  )
                : Text(
                    comment,
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
