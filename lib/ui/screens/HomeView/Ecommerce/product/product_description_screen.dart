import 'package:bukizz_1/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ProductDescriptionScreen extends StatefulWidget {
  static const String route = '/productdescription';
  const ProductDescriptionScreen({Key? key}) : super(key: key);

  @override
  State<ProductDescriptionScreen> createState() => _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  PageController _pageController = PageController();
  double _currentPage = 0;

  List<String> images = [
    'assets/school/perticular bookset/book.png',
    'assets/school/perticular bookset/book.png',
    'assets/school/perticular bookset/book.png',
    // Add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        width: dimensions.screenWidth,
        height: dimensions.screenHeight,
        child: SingleChildScrollView(
          child: Container(
            height: dimensions.height240,
            child: ListView.builder(


            itemBuilder: (context,index){
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage( 'assets/school/perticular bookset/book.png',),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
          ),
        ),
      ),
    )
  );
 }
}

