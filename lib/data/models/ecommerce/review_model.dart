class ReviewModel{
  String? reviewId;
  String? productId;
  String? userId;
  String? userName;
  String? review;
  double? rating;
  String? createdAt;
  String image;
  String video;

  ReviewModel({
    this.reviewId,
    this.productId,
    this.userId,
    this.userName,
    this.review,
    this.rating,
    this.createdAt,
    required this.image,
    required this.video,
  });

  // Convert from JSON string to ReviewModel object
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json['reviewId'],
      productId: json['productId'],
      userId: json['userId'],
      userName: json['userName'],
      review: json['review'],
      rating: json['rating']?.toDouble(),
      createdAt: json['createdAt'],
      image: json['image'] ?? '', // Handle null case
      video: json['video'] ?? '', // Handle null case
    );
  }

  // Convert from ReviewModel object to JSON string
  Map<String, dynamic> toJson() {
    return {
      'reviewId': reviewId,
      'productId': productId,
      'userId': userId,
      'userName': userName,
      'review': review,
      'rating': rating,
      'createdAt': createdAt,
      'image': image,
      'video': video,
    };
  }

  // Convert from Map to ReviewModel object
  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      reviewId: map['reviewId'],
      productId: map['productId'],
      userId: map['userId'],
      userName: map['userName'],
      review: map['review'],
      rating: map['rating']?.toDouble(),
      createdAt: map['createdAt'],
      image: map['image'] ?? '', // Handle null case
      video: map['video'] ?? '', // Handle null case
    );
  }

  // Convert from ReviewModel object to Map
  Map<String, dynamic> toMap() {
    return {
      'reviewId': reviewId,
      'productId': productId,
      'userId': userId,
      'userName': userName,
      'review': review,
      'rating': rating,
      'createdAt': createdAt,
      'image': image,
      'video': video,
    };
  }

}