class ReviewModel{
  String? reviewId;
  String? productId;
  String? userId;
  String? review;
  double? rating;
  DateTime? createdAt;

  ReviewModel({
    this.reviewId,
    this.productId,
    this.userId,
    this.review,
    this.rating,
    this.createdAt
  });

  ReviewModel.fromJson(Map<String, dynamic> json){
    reviewId = json['id'];
    productId = json['productId'];
    userId = json['userId'];
    review = json['review'];
    rating = json['rating'];
    createdAt = DateTime.parse(json['createdAt']);
  }

  Map<String, dynamic> toJson(){
    return {
      'reviewId': reviewId,
      'productId': productId,
      'userId': userId,
      'review': review,
      'rating': rating,
      'createdAt': createdAt.toString()
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      reviewId: map['reviewId'] ?? '',
      productId: map['productId'] ?? '',
      userId: map['userId'] ?? '',
      review: map['review'] ?? '',
      rating: map['rating'] ?? 0.0,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toString())
    );
  }
}