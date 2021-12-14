
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Review.dart';
import 'package:shop_app/provider/review_provider.dart';
import 'package:shop_app/screens/review/review_card.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'defaultAppBar.dart';
import 'defaultBackButton.dart';

class Reviews extends StatefulWidget {
  String id;

  Reviews({Key? key, required String this.id}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool isMore = false;
  double totalRate = 0;
  double totalRate1 = 0;
  double totalRate2 = 0;
  double totalRate3 = 0;
  double totalRate4 = 0;
  double totalRate5 = 0;

  List<double> ratings = [];

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);
    List<ReviewModel> reviewPro = [];

    //get list review
    for (int i = 0;i < reviewProvider.reviews.length ; i++){
      if (reviewProvider.reviews[i].idPro == widget.id){
        reviewPro.add(reviewProvider.reviews[i]);
      }
    }

    //get rating
    for (int i = 0; i< reviewPro.length; i++)
      {
        totalRate += reviewPro[i].rating;
        if (reviewPro[i].rating == 1)
          {
            totalRate1 ++;
          }
        else if (reviewPro[i].rating == 2)
          {
            totalRate2 ++;
          }
        else if (reviewPro[i].rating == 3)
          {
            totalRate3 ++;
          }
        else if (reviewPro[i].rating == 4)
          {
            totalRate4 ++;
          }
        else if (reviewPro[i].rating == 5)
          {
            totalRate5 ++;
          }
      }
    ratings.add(totalRate1/reviewPro.length);
    ratings.add(totalRate2/reviewPro.length);
    ratings.add(totalRate3/reviewPro.length);
    ratings.add(totalRate4/reviewPro.length);
    ratings.add(totalRate5/reviewPro.length);


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
                            text: NumberFormat("0.#").format(totalRate/reviewPro.length).toString(),
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
                      rating: totalRate/reviewPro.length,
                      size: 20.0,
                      color: Color(0xFFFFC416),
                      borderColor: Color(0xFFFFC416),
                    ),
                    SizedBox(height: 14.0),
                    Text(
                      "${reviewPro.length} Reviews",
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
              itemCount: reviewPro.length,
              itemBuilder: (context, index) {
                return ReviewCard(
                  review: reviewPro[index],
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
