import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/data/models/ecommerce/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../ui/screens/HomeView/Ecommerce/profile/add_review.dart';

class ReviewRepository with ChangeNotifier {
  ReviewModel randomReview = ReviewModel(
    reviewId: '',
    userId: '',
    userName: '',
    productId: '',
    review: '',
    rating: 0,
    image: '',
    video: '',
  );

  String _productName = '';

  String get productName => _productName;

  set productName(value)
  {
    _productName = value;
    notifyListeners();
  }

  String _productId = '';

  String get productId => _productId;
  set productId(value){
    _productId = value;
    notifyListeners();
  }

  String _deliveryStatus = '';

  String get deliveryStatus => _deliveryStatus;

  set deliveryStatus(value){
    _deliveryStatus = value;
    notifyListeners();
  }

  int _rating = 0;

  int get rating => _rating;

  set rating(value)
  {
    _rating = value;
    notifyListeners();
  }

  String _orderId = '';

  String get orderId => _orderId;

  set orderId(value){
    _orderId = value;
    notifyListeners();
  }

  void setReviewInitData(int rate , BuildContext context)
  {
    rating = rate;
    Future.delayed(const Duration(milliseconds: 250), () {
      Navigator.pushNamed(context, ReviewScreen.route);
    });
    notifyListeners();
  }

  var uuid = Uuid();

  void setFinalReviewData(String review , String image , String video , BuildContext context)
  {
    try{
      randomReview = ReviewModel(
        reviewId: uuid.v1(),
        userId: AppConstants.userData.uid,
        userName: AppConstants.userData.name,
        productId: productId,
        review: review,
        rating: rating.toDouble(),
        image: image,
        video: video,
      );
      pushRandomReview(context);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
    catch(e){
      print("Error Coming in Review");
    }
    notifyListeners();
  }

  void pushRandomReview(BuildContext context) async {
    try{
      await FirebaseFirestore.instance.collection('reviews').doc(randomReview.reviewId).set(randomReview.toMap());
      await FirebaseFirestore.instance
          .collection('orderDetails')
          .doc(orderId)
          .update({
        'reviewId': randomReview.reviewId,
      }).then((value) => print('Review ID added to user details')).catchError((e)=>{print(e)});

      if(context.mounted)
        {
          AppConstants.showSnackBar(context, "Review Added Successfully");
        }
      rating = 0;
      productId = '';
      orderId = '';
    }
    catch(e){
      debugPrint("Error in Pushing Review Data");
    }
    notifyListeners();
  }

}
