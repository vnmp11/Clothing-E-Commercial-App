import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';


class EmptySection extends StatelessWidget {
  final String emptyImg, emptyMsg;
  const EmptySection({
    Key? key,
    required this.emptyImg,
    required this.emptyMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(emptyImg),
            height: 170.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: kLessPadding),
            child: Text(
              emptyMsg,
              style: TextStyle(
                fontSize: 20.0,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
