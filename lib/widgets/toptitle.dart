import 'package:flutter/material.dart';
import 'package:flutter_food_app/utils/color_constants.dart';

class TopTitle extends StatelessWidget {
  String title, subtitle;
  TopTitle({required this.title,required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 400,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 40,
                color: Color1.textColor,
                fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 30,
              color: Color1.textColor,
            ),
          )
        ],
      ),
    );
  }
}
