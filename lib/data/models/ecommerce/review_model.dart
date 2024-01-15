class ReviewModel{
  String? id;
  String? productId;
  String? userId;
  String? userName;
  String? userImage;
  String? review;
  double? rating;
  DateTime? createdAt;

  ReviewModel({
    this.id,
    this.productId,
    this.userId,
    this.userName,
    this.userImage,
    this.review,
    this.rating,
    this.createdAt
  });

  ReviewModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productId = json['productId'];
    userId = json['userId'];
    userName = json['userName'];
    userImage = json['userImage'];
    review = json['review'];
    rating = json['rating'];
    createdAt = DateTime.parse(json['createdAt']);
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'productId': productId,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'review': review,
      'rating': rating,
      'createdAt': createdAt.toString()
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] ?? '',
      productId: map['productId'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userImage: map['userImage'] ?? '',
      review: map['review'] ?? '',
      rating: map['rating'] ?? 0.0,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toString())
    );
  }
}