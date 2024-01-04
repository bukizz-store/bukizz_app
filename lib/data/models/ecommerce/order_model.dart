
class OrderModel {
  String orderId;
  String userId;
  DateTime orderDate;
  double totalAmount;
  List<String> products;
  int totalPrice;
  

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.orderDate,
    required this.totalAmount,
    required this.products,
    required this.totalPrice,
  });
}