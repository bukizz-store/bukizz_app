import 'package:flutter/material.dart';

import '../constants/font_family.dart';

Row signUpOption(String text1, String text2 , BuildContext context , String newRouteName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text1,
        style: TextStyle(
          color: Color(0xFFA6A6A6),
          fontFamily: FontFamily.roboto.name,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),

      GestureDetector(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(context, newRouteName, (route) => false);
        },
        child: Text(
          text2,
          style: TextStyle(
            color: Color(0xFF03045E),
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: FontFamily.roboto.name,
          ),
        ),
      ),
    ],
  );
}



Center termsAndService(String text1, String text2,VoidCallback onTap) {
  return Center(
    child: Column(

      children: [
        Text(
          text1,
          style: TextStyle(
            color: Color(0xFFA6A6A6),
            fontFamily: FontFamily.roboto.name,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text2,
            style: TextStyle(
              color: Color(0xFF03045E),
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontFamily: FontFamily.roboto.name,
            ),
          ),
        ),
      ],
    ),
  );
}

Center hyperText(String text1, String text2,VoidCallback onTap) {
  return Center(
    child: Row(

      children: [
        Text(
          text1,
          style: TextStyle(
            color: Color(0xFFA6A6A6),
            fontFamily: FontFamily.roboto.name,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text2,
            style: TextStyle(
              color: Color(0xFF03045E),
              fontWeight: FontWeight.w500,
              fontSize: 16,
              fontFamily: FontFamily.roboto.name,
            ),
          ),
        ),
      ],
    ),
  );
}
