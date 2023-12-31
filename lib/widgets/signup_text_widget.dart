import 'package:bukizz_frontend/constants/font_family.dart';
import 'package:flutter/material.dart';

Row signUpOption(String text1, String text2) {
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
          print('hello');
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



Center termsAndService(String text1, String text2) {
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
          onTap: () {
            print('hello');
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
    ),
  );
}
