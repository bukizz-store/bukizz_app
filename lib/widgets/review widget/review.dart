import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repository/review/product_Reviews.dart';
import '../text and textforms/Reusable_text.dart';


class ReviewListWidget extends StatefulWidget {
  @override
  _ReviewListWidgetState createState() => _ReviewListWidgetState();
}

class _ReviewListWidgetState extends State<ReviewListWidget> {
  int visibleReviews = 1; // Number of reviews initially visible
  List<String> reviews = [
    "Great product! The quality is excellent.",
    "Awesome service! Fast delivery and good customer support.",
    "product sucks, Hated it,shit product",
    "Highly recommended! Will buy again."
  ]; // Sample reviews

  List<String> names = [
    "Sugam",
    "Garvit",
    "Shivam",
    "Aman",
  ];
  // Sample names corresponding to reviews

  List<int> ratings = [
    5,
    4,
    1,
    3,
  ];

  bool showLess = true; // Track whether to show fewer reviews

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Consumer<ProductReview>(builder: (context , productReview , child){
      return !productReview.isReviewLoaded ?  Container(
        width: dimensions.screenWidth,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dimensions.width24,
            vertical: dimensions.height24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                text: 'Ratings & Reviews',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF121212),
              ),
              SizedBox(height: dimensions.height24 / 2),
              Row(
                children: List.generate(
                  4,
                      (index) => Icon(
                    Icons.star,
                    color: Color(0xFF058FFF),
                  ),
                ),
              ),
              SizedBox(height: dimensions.height24 / 2),
              ReusableText(
                text: '${productReview.reviews.length} ratings',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF444444),
              ),
              SizedBox(height: dimensions.height24),

              productReview.reviews.length >0 ?  Column(
                children: [
                  for (int index = 0; index < (showLess ? 1 : visibleReviews); index++)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ReviewWidget(
                        reviewText: productReview.reviews[index].review!,
                        userName: productReview.reviews[index].userName!,
                        rating: productReview.reviews[index].rating!.toInt(),
                      ),
                    ),

                  // Show More/Show Less buttons
                  InkWell(
                    onTap: () {
                      setState(() {
                        showLess = !showLess;
                        if (showLess) {
                          visibleReviews = 1;
                        } else {
                          visibleReviews = productReview.reviews.length;
                        }
                      });
                    },
                    child: Container(
                      child: Row(
                        children: [
                          ReusableText(
                            text: showLess ? 'Show More' : 'Show Less',  // Fix this line
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF00579E),
                          ),
                          Icon(
                            showLess
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            color: Color(0xFF00579E),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ) : Container()
              // Display reviews based on visibility
            ],
          ),
        ),
      ) : Center(child: CircularProgressIndicator(),);
    });
  }
}

class ReviewWidget extends StatelessWidget {
  final String reviewText;
  final String userName;
  int rating;

  ReviewWidget({required this.reviewText,required this.userName ,required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Star ratings (you can customize this part)
        Row(
          children: List.generate(rating, (index) {
            return Icon(
              Icons.star,
              color: Colors.amber,
            );
          }),
        ),

        // Text review
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            reviewText,
            style: TextStyle(fontSize: 16),
          ),
        ),

        // User's name (you can add more user details here)
        Text(
          userName,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
