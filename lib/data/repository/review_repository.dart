
import 'package:bukizz_1/data/models/ecommerce/review_model.dart';
import 'package:flutter/foundation.dart';

class ReviewRepository with ChangeNotifier {


  void generateReview(){

    ReviewModel randomReview = ReviewModel(
      reviewId: '',
      userId: '',
      productId: '',
      review: '',
      rating: 0,
    );
    // pushRandomReview();
  }


  void pushRandomReview() async {
    // await FirebaseFirestore.instance.collection('reviews').add({
    //   'reviewId': uuid.v1(),
    //   'userId': AppConstants.userData.uid,
    //   'productId': productId,
    //   'schoolName': schoolName,
    //   'review': review,
    //   'rating': rating,
    //   'reviewDate': DateTime.now(),
    // });
  }

}
