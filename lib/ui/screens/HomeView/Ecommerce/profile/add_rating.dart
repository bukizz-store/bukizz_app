import 'package:bukizz/data/repository/my_orders.dart';
import 'package:bukizz/data/repository/review/review_repository.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/add_review.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
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
    print("Again Print");
    Dimensions dimensions = Dimensions(context);
    return Consumer<ReviewRepository>(builder: (context , reviewData , child){
      _rating = reviewData.rating.toDouble();
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Review Product'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(height: dimensions.height16,color: Color(0xFFE0F0FF),),
            Container(
              alignment: Alignment.center,
              width: dimensions.width10 * 15,
              height: dimensions.height10 * 15,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0,-1)
                  )
                ],
                borderRadius: BorderRadius.circular(dimensions.width10),
                // color: Colors.red
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  dimensions.width10 * 7.6 / 8,
                ),
                child: CachedNetworkImage(
                  // 'assets/school/booksets/${reviewData.productId.substring(3)}.svg',

                  fit: BoxFit.cover,
                  imageUrl: context.read<MyOrders>().getImage,
                ),
              ),
            ),
            SizedBox(height: dimensions.height10*2),
            SizedBox(
              width: dimensions.width342,
              child: Text(
                '${reviewData.productName} is ${reviewData.deliveryStatus}',
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
            height: dimensions.height10 * 10.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) => IconButton(
                      icon: Icon(
                        index < _rating ? Icons.star : Icons.star_border_outlined,
                        color: index < _rating ? Color(0xFF058FFF) : Color(0xFFD6D6D6),
                        size: 50,
                      ),
                      onPressed: () {
                        reviewData.setReviewInitData(index + 1, context);
                      },
                    ),
              ),
            ),
          ),




          SizedBox(height: 20),

          ],
        ),
      );
    });
  }
}


