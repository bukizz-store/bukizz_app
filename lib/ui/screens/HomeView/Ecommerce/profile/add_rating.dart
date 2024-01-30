import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/profile/add_review.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../utils/dimensions.dart';

class RatingsScreen extends StatefulWidget {
  static const route = '/rating';
  const RatingsScreen({super.key});

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> {
  double _rating = 0;
  String _selectedSentiment = '';

  void _setRating(double rating) {
    setState(() {
      _rating = rating;
    });


    Future.delayed(Duration(milliseconds: 250), () {
      Navigator.pushNamed(context, ReviewScreen.route);
    });
  }


  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Review Product'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: dimensions.height16,color: Color(0xFFE0F0FF),),
          SizedBox(height: dimensions.height10*17,),
          Container(
            alignment: Alignment.center,
            width: dimensions.width10 * 15,
            height: dimensions.height10 * 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dimensions.width10),
              // color: Colors.red
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                dimensions.width10 * 7.6 / 8,
              ),
              child: SvgPicture.asset(
                'assets/school/booksets/1.svg',
                fit: BoxFit.cover,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(height: dimensions.height10*2),
          SizedBox(
            width: dimensions.width342,
            child: const Text(
              'Your product English Book Set - Wisdom World School - Class 1st is delivered',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF121212),
                fontSize: 14,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),

          SizedBox(height: dimensions.height10*3.6),
          
          ReusableText(text: 'Rate the product', fontSize: 20,fontWeight: FontWeight.w700,color: Color(0xFF121212),),
          // Add a star rating widget
          Container(
            height: dimensions.height10 * 10.5, // Adjust the height as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) => IconButton(
                  iconSize: dimensions.height10 * 3, // Adjust the size of the star icon
                  icon: Icon(
                    Icons.star,
                    color: index < _rating ? Color(0xFF058FFF) : Color(0xFFD6D6D6),
                    size: 50,
                  ),
                  onPressed: () {
                    _setRating(index + 1.0);
                  },
                ),
              ),
            ),
          ),



          SizedBox(height: 20),

        ],
      ),
    );
  }
}


