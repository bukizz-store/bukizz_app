import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/ecommerce/review_model.dart';

class ProductReview extends ChangeNotifier {
  List<ReviewModel> reviews = [];

  String _productId = '';
  String get productId => _productId;

  set productId(value){
    _productId = value;
    notifyListeners();
  }

  bool _isReviewLoaded = false;

  bool get isReviewLoaded => _isReviewLoaded;

  set isReviewLoaded(value){
    _isReviewLoaded = value;
    notifyListeners();
  }

  void fetchReviews(String productId) async {
      isReviewLoaded = true;
    try {
      this.productId = productId;
      reviews = await FirebaseFirestore.instance
          .collection("reviews")
          .where('productId', isEqualTo: productId)
          .get()
          .then((value) =>
              value.docs.map((e) => ReviewModel.fromMap(e.data())).toList());
    } catch (e) {
      debugPrint("Error in Getting Products");
    }

      isReviewLoaded = false;
  }


}
