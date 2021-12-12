
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shop_app/models/Review.dart';
import 'package:shop_app/screens/review/review_card.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'defaultAppBar.dart';
import 'defaultBackButton.dart';

class Reviews extends StatefulWidget {
  Reviews({Key? key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool isMore = false;
  List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: "Reviews", child: DefaultBackButton(),
      ),
      body: Column(
        children: [
          Container(
            color: kSecondaryColor.withOpacity(0.1),
            padding: EdgeInsets.all(getProportionateScreenWidth(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "4.5",
                            style: TextStyle(fontSize: 48.0, color: kPrimaryColor),
                          ),
                          TextSpan(
                            text: "/5",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SmoothStarRating(
                      starCount: 5,
                      rating: 4.5,
                      size: 20.0,
                      color: Color(0xFFFFC416),
                      borderColor: Color(0xFFFFC416),
                    ),
                    SizedBox(height: 14.0),
                    Text(
                      "${reviewList.length} Reviews",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                  width: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(width: 4.0),
                          Icon(Icons.star, color:  Color(0xFFFFC416)),
                          SizedBox(width: 8.0),
                          LinearPercentIndicator(
                            lineHeight: 6.0,
                            // linearStrokeCap: LinearStrokeCap.roundAll,
                            width: 100,
                            animation: true,
                            animationDuration: 2500,
                            percent: ratings[index],
                            progressColor: kPrimaryColor,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              itemCount: reviewList.length,
              itemBuilder: (context, index) {
                return ReviewCard(
                  image: reviewList[index].image,
                  name: reviewList[index].name,
                  date: reviewList[index].date,
                  comment: reviewList[index].comment,
                  rating: reviewList[index].rating,
                  onPressed: () => print("More Action $index"),
                  onTap: () => setState(() {
                    isMore = !isMore;
                  }),
                  isLess: isMore,
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 2.0,
                  color: kAccentColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
