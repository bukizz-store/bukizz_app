
class OrderModel {
  String orderId;
  String userId;
  DateTime orderDate;
  double totalAmount;
  List<String> products;
  

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.orderDate,
    required this.totalAmount,
    required this.products,
  });
}