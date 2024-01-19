import 'package:bukizz_1/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final String hintText;

  CustomTextForm({
    required this.width,
    required this.height,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Container(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical:dimensions.height8,horizontal: dimensions.height8),
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xFF7A7A7A)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(height/2),
            borderSide: BorderSide(color: Color(0xFF7A7A7A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(height/2),
            borderSide: BorderSide(color: Colors.black38),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom TextForm Example'),
        ),
        body: Center(
          child: CustomTextForm(
            width: 200.0,
            height: 50.0,
            controller: TextEditingController(),
            hintText: 'Enter text',
          ),
        ),
      ),
    );
  }
}
