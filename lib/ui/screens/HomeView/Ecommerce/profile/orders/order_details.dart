import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/data/repository/my_orders.dart';
import 'package:bukizz/data/repository/query/order_query.dart';
import 'package:bukizz/data/repository/review/review_repository.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/add_rating.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/queryContact/contact_for_query.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../../../data/models/ecommerce/products/product_model.dart';
import '../../../../../../data/models/ecommerce/products/variation/set_model.dart';
import '../../../../../../utils/dimensions.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const route = '/orderdetails';
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  double totalPrice = 0;
  double salePrice = 0;
  bool dropDown = false;

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Consumer<MyOrders>(builder: (context, orderData, child) {
      if (!orderData.isOrderDataLoaded) {
        return const Scaffold(
          body: Center(
            child: SpinKitChasingDots(
              size: 24,
              color: AppColors.primaryColor,
            ),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: ReusableText(
            text: 'My Orders',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        body: orderData.isOrderDataLoaded
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: dimensions.height16,
                          color: Color(0xFFF5FAFF),
                        ),
                        Column(
                          children: [
                            // Order Status Timeline

                            SizedBox(height: dimensions.height16),

                            // Container(
                            //   width: dimensions.screenWidth,
                            //   height: dimensions.height10 * 11.3,
                            //   padding: EdgeInsets.only(
                            //       left: dimensions.width16, top: dimensions.height10),
                            //   color: Colors.white,
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //         width: dimensions.width10 * 7.6,
                            //         height: dimensions.height10 * 7.6,
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(
                            //             dimensions.width10,
                            //           ),
                            //         ),
                            //         child: ClipRRect(
                            //             borderRadius: BorderRadius.circular(
                            //               dimensions.width10,
                            //             ),
                            //             child: Image.asset('assets/orders.png')
                            //         ),
                            //       ),
                            //       SizedBox(width: dimensions.width16),
                            //       Column(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           SizedBox(
                            //             height: dimensions.height10,
                            //           ),
                            //           ReusableText(
                            //               text: '${orderData.cartLength} items',
                            //               fontSize: 12),
                            //           SizedBox(
                            //             height: dimensions.height10,
                            //           ),
                            //           SizedBox(
                            //             width: dimensions.width10 * 25.2,
                            //             child: Text(
                            //               'Your product ${orderData.selectedOrderModel.orderName} is ${orderData.selectedOrderModel.status}',
                            //               style: const TextStyle(
                            //                 color: Color(0xFF444444),
                            //                 fontSize: 12,
                            //                 fontFamily: 'Nunito',
                            //                 fontWeight: FontWeight.w400,
                            //                 height: 0,
                            //                 overflow: TextOverflow.ellipsis
                            //               ),
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             height: dimensions.height10,
                            //           ),
                            //           ReusableText(
                            //             text: 'Ordered On: ${orderData.selectedOrderModel.orderDate.substring(0, 10)}',
                            //             fontSize: 12,
                            //             color: Color(0xFFA5A5A5),
                            //             fontWeight: FontWeight.w500,
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Container(
                                width: dimensions.screenWidth,
                                color: Colors.white,
                                child: Container(
                                  child: Column(
                                    children: _buildWidget(
                                        orderData, context, dimensions),
                                  ),
                                )),
                            Container(
                              width: dimensions.screenWidth,
                              color: Colors.white,
                              padding: EdgeInsets.all(dimensions.width16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReusableText(
                                    text: 'Order Status',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF121212),
                                  ),
                                  SizedBox(height: dimensions.height16),
                                  _buildOrderStatusTimeline(
                                      orderData.selectedOrderModel.status,
                                      orderData.selectedOrderModel.orderDate,
                                      dimensions),
                                ],
                              ),
                            ),
                            SizedBox(height: dimensions.height16),
                            Container(
                              width: dimensions.screenWidth,
                              color: Colors.white,
                              padding: EdgeInsets.all(dimensions.width16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReusableText(
                                    text: 'Delivery Address',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF121212),
                                  ),
                                  SizedBox(height: dimensions.height16),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: dimensions.width24),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: dimensions.screenWidth - (dimensions.width16 * 2),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Deliver To : ',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: const Color(0xFF121212),
                                                        fontFamily: 'Nunito',
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: orderData.selectedOrderModel.address.name,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: const Color(0xFF121212),
                                                        fontFamily: 'Nunito',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          
                                            SizedBox(
                                                height: dimensions.height8),
                                            SizedBox(
                                              width: dimensions.screenWidth -
                                                  (dimensions.width16 * 2),
                                              child: Text(
                                                '${orderData.selectedOrderModel.address.houseNo}, ${orderData.selectedOrderModel.address.street}, ${orderData.selectedOrderModel.address.city}, ${orderData.selectedOrderModel.address.state} - ${orderData.selectedOrderModel.address.pinCode}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xFF121212),
                                                  fontFamily: 'Nunito',
                                                ),
                                                maxLines: null,
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                            SizedBox(
                                                height: dimensions.height8),
                                            SizedBox(
                                              width: dimensions.screenWidth -
                                                  (dimensions.width16 * 2),
                                              child: ReusableText(
                                                text:
                                                    'Phone: ${orderData.selectedOrderModel.address.phone}',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF121212),
                                              ),
                                            ),
                                          ])),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: dimensions.height16),

                        //Delivery Address
                        //total amount text
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensions.width16,
                              vertical: dimensions.height16 / 2),
                          width: dimensions.screenWidth,
                          height: null,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    dropDown = !dropDown;
                                  });
                                },
                                child: Row(
                                  children: [
                                    ReusableText(
                                      text: 'Total Amount',
                                      fontSize: 18,
                                      color: Color(0xFF282828),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    dropDown
                                        ? Icon(Icons.arrow_drop_up)
                                        : Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                              ReusableText(
                                text: '₹${salePrice + 40}',
                                fontSize: 18,
                                color: Color(0xFF121212),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    (dropDown)
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: dimensions.width16,
                                vertical: dimensions.height16 / 2),
                            width: dimensions.screenWidth,
                            height: null,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //total price
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: dimensions.width10 * 26.4,
                                      child: Text(
                                        'Price(${orderData.cartLength} items)',
                                        style: const TextStyle(
                                            color: Color(0xFF7A7A7A),
                                            fontSize: 16,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    ReusableText(
                                      text:
                                          '₹${orderData.selectedOrderModel.totalAmount}',
                                      fontSize: 16,
                                      color: Color(0xFF121212),
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: dimensions.height8,
                                ),
                                //discount
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReusableText(
                                      text: 'Discount',
                                      fontSize: 16,
                                      color: Color(0xFF7A7A7A),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    ReusableText(
                                        text:
                                            '-₹${orderData.selectedOrderModel.totalAmount - orderData.selectedOrderModel.saleAmount}',
                                        fontSize: 16,
                                        color: Color(0xFF038B10),
                                        fontWeight: FontWeight.w500)
                                  ],
                                ),
                                SizedBox(
                                  height: dimensions.height8 * 2.5,
                                ),
                                //delivery charges
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReusableText(
                                      text: 'Delivery Charges',
                                      fontSize: 16,
                                      color: Color(0xFF7A7A7A),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    ReusableText(
                                      text:
                                          '₹${orderData.selectedOrderModel.deliveryCharge}',
                                      fontSize: 16,
                                      color: Color(0xFF121212),
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: dimensions.height8 * 1.5,
                                ),
                                //horizontal line
                                Container(
                                  width: dimensions.screenWidth,
                                  height: 1,
                                  color: Color(0xFFD6D6D6),
                                ),
                                SizedBox(
                                  height: dimensions.height8 * 2.5,
                                ),
                                //total amount
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ReusableText(
                                      text: 'Total Amount',
                                      fontSize: 16,
                                      color: Color(0xFF282828),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    ReusableText(
                                      text:
                                          '₹${orderData.selectedOrderModel.saleAmount + orderData.selectedOrderModel.deliveryCharge}',
                                      fontSize: 16,
                                      color: Color(0xFF121212),
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: dimensions.height8 * 1.5,
                                ),
                                Container(
                                  width: dimensions.screenWidth,
                                  height: 1,
                                  color: Color(0xFFD6D6D6),
                                ),
                                SizedBox(
                                  height: dimensions.height8 * 1.5,
                                ),
                                ReusableText(
                                  text:
                                      'You will save ₹${orderData.selectedOrderModel.totalAmount - orderData.selectedOrderModel.saleAmount} on this order',
                                  fontSize: 16,
                                  color: Color(0xFF038B10),
                                  fontWeight: FontWeight.w700,
                                )
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: dimensions.height24 * 2,
                    ),

                    orderData.selectedOrderModel.status.toLowerCase() != 'cancelled' &&
                orderData.selectedOrderModel.status.toLowerCase() != 'completed' &&
                orderData.selectedOrderModel.status.toLowerCase() != 'shipped'
            ? Container(
                height: dimensions.height8 * 8,
                width: dimensions.screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.3),
                  //     spreadRadius: 1,
                  //     blurRadius: 5,
                  //     offset: Offset(0, -3),
                  //   ),
                  // ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensions.width24,
                      vertical: dimensions.height10
                      ),
                  child: ElevatedButton(
                    onPressed: () => _showCancelOrderDialog(context, orderData),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        
                      ),
                      side: BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                      padding: EdgeInsets.symmetric(vertical: dimensions.height8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(Icons.cancel, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Cancel Order',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
                  ],
                ),
              )
            : Center(
                child: SpinKitChasingDots(
                  size: 24,
                ),
              ),
        // Add bottom navigation bar for cancel button if order can be cancelled
      );
    });
  }

  // Build order status timeline widget
  Widget _buildOrderStatusTimeline(
      String currentStatus, String orderDate, Dimensions dimensions) {
    
    // Check if order is cancelled
    bool isCancelled = currentStatus.toLowerCase() == 'cancelled';
    
    List<Map<String, dynamic>> statusList = [
      {
        'title': 'Order Confirmed',
        'status': 'initiated',
        'date': orderDate.substring(0, 10).replaceAll('-', ' '),
      },
      {
        'title': 'Order Shipped',
        'status': 'packed',
        'date': '',
      },
      {
        'title': 'Out for Delivery',
        'status': 'shipped',
        'date': '',
      },
      {
        'title': 'Delivered',
        'status': 'completed',
        'date': '',
      },
    ];

    // If cancelled, add cancelled status at the end
    if (isCancelled) {
      statusList.add({
        'title': 'Order Cancelled',
        'status': 'cancelled',
        'date': '',
      });
    }

    int getCurrentStatusIndex() {
      switch (currentStatus.toLowerCase()) {
        case 'initiated':
          return 0;
        case 'packed':
          return 1;
        case 'shipped':
          return 2;
        case 'completed':
          return 3;
        case 'cancelled':
          return statusList.length - 1; // Last position for cancelled
        default:
          return 0;
      }
    }

    int currentIndex = getCurrentStatusIndex();

    // Format the order date for display
    String formatDate(String dateStr) {
      try {
        DateTime date = DateTime.parse(dateStr);
        List<String> months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec'
        ];
        return "${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')} ${date.year}";
      } catch (e) {
        return dateStr;
      }
    }

    return Container(
      child: Column(
        children: List.generate(statusList.length, (index) {
          bool isCompleted = isCancelled ? (index == 0 || index == statusList.length - 1) : index <= currentIndex;
          bool isLast = index == statusList.length - 1;
          bool isCancelledStep = statusList[index]['status'] == 'cancelled';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Circle indicator
                  Column(children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCancelledStep 
                            ? Colors.red 
                            : isCompleted 
                                ? Color(0xFF00C853) 
                                : Color(0xFFE0E0E0),
                      ),
                      child: isCompleted
                          ? Icon(
                              isCancelledStep ? Icons.close : Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                          : null,
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 30,
                        color: Color(0xFFE0E0E0),
                      ),
                  ]),

                  SizedBox(width: dimensions.width16),
                  // Status text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statusList[index]['title'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isCancelledStep 
                                ? Colors.red 
                                : isCompleted
                                    ? Color(0xFF121212)
                                    : Color(0xFF7A7A7A),
                            fontFamily: 'Nunito',
                          ),
                        ),
                        if (index == 0 && statusList[index]['date'].isNotEmpty)
                          Text(
                            formatDate(orderDate),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF7A7A7A),
                              fontFamily: 'Nunito',
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  String setProductName(
      String school, String set, String stream, ProductModel product) {
    String streamName = product.stream.isNotEmpty ? "- $stream" : '';
    String setName = product.set.isNotEmpty ? "($set)" : '';
    return "$school - ${product.name}$streamName $setName";
  }

  int setTotalSalePrice(ProductModel product, String set, String stream) {
    SetData setData = product.set.where((element) => element.name == set).first;
    int totalSalePrice = product
        .variation[product.set.indexOf(setData).toString()]![
            product.stream.isNotEmpty
                ? product.stream
                    .indexOf(product.stream
                        .where((element) => element.name == stream)
                        .first)
                    .toString()
                : '0']!
        .salePrice;
    return totalSalePrice;
  }

  int setTotalPrice(ProductModel product, String set, String stream) {
    int totalPrice = product
        .variation[product.set
            .indexOf(product.set.where((element) => element.name == set).first)
            .toString()]![product
                .stream.isNotEmpty
            ? product.stream
                .indexOf(product.stream
                    .where((element) => element.name == stream)
                    .first)
                .toString()
            : '0']!
        .price;
    return totalPrice;
  }

  List<Widget> _buildWidget(
      MyOrders orderData, BuildContext context, dimensions) {
    totalPrice = 0;
    salePrice = 0;
    List<Widget> list = [];

    if (orderData.isOrderDataLoaded) {
      orderData.selectedOrder.forEach((schoolName, productData) {
        productData.forEach((product, setData) {
          setData.forEach((set, streamData) {
            streamData.forEach((stream, data) {
              ProductModel productModel = orderData.orderedProduct
                  .where((element) => element.productId == product)
                  .first;
              String productName =
                  setProductName(schoolName, set, stream, productModel);
              int totalSalePrice = setTotalSalePrice(productModel, set, stream);
              int price = setTotalPrice(productModel, set, stream);
              orderData.setImage = productModel
                  .variation[productModel.set
                          .indexOf(productModel.set
                              .where((element) => element.name == set)
                              .first)
                          .toString()][
                      productModel.stream.isNotEmpty
                          ? productModel.stream
                              .indexOf(productModel.stream
                                  .where((element) => element.name == stream)
                                  .first)
                              .toString()
                          : '0']
                  .image[0];
              totalPrice += price * data[0];
              salePrice += totalSalePrice * data[0];
              list.add(Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: dimensions.height8 * 2,
                    vertical: dimensions.width10 * 1.8),
                child: Container(
                  width: dimensions.width10 * 39.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ReusableText(
                            text: 'Your order is',
                            fontSize: 16,
                            color: Color(0xFF444444),
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            width: dimensions.width10 / 2,
                          ),
                          ReusableText(
                            text: data[2],
                            fontSize: 16,
                            color: Color(0xFF444444),
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      ReusableText(
                        text:
                            '${DateTime.now().difference(DateTime.parse(orderData.selectedOrderModel.orderDate)).inDays.abs()} Day ago',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF7A7A7A),
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: dimensions.width10 * 7.6,
                            height: dimensions.height10 * 7.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                dimensions.width10,
                              ),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  dimensions.width10,
                                ),
                                child: Image.network(orderData.getImage)),
                          ),
                          SizedBox(
                            width: dimensions.width16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: dimensions.width10 * 25.2,
                                child: Text(
                                  'Your product $productName delivery is ${orderData.selectedOrderModel.status}',
                                  style: TextStyle(
                                    color: Color(0xFF444444),
                                    fontSize: 12,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: dimensions.height16,
                              ),
                              ReusableText(
                                text: '₹ $salePrice',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF121212),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: dimensions.height8 * 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              context
                                  .read<OrderQueryRepository>()
                                  .setInitialData(
                                    orderData.selectedOrderModel.orderId,
                                    productName,
                                    orderData.selectedOrderModel.address.phone,
                                  );
                              Navigator.pushNamed(
                                  context, KnowMoreScreen.route);
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              side: BorderSide(
                                  color: Color(0xFF7A7A7A), width: 2),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.contact_support,
                                  color: Color(0xFF7A7A7A),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Contact Us',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF7A7A7A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              context.read<ReviewRepository>().productName =
                                  productName;
                              context.read<ReviewRepository>().deliveryStatus =
                                  data[2];
                              context.read<ReviewRepository>().productId =
                                  product;
                              context.read<ReviewRepository>().orderId =
                                  orderData.selectedOrderModel.orderId;
                              Navigator.pushNamed(context, RatingsScreen.route);
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              backgroundColor: Color(0xFF058FFF),
                              side: BorderSide(
                                  color: Color(0xFF058FFF), width: 2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Add Review',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: dimensions.height10 * 2,
                      ),
                      Container(
                        width: dimensions.screenWidth,
                        height: 1,
                        color: Color(0xFFD6D6D6),
                      ),
                    ],
                  ),
                ),
              ));
            });
          });
        });
      });
    }
    return list;
  }

  // Show cancel order confirmation dialog
  void _showCancelOrderDialog(BuildContext context, MyOrders orderData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isLoading = false;
        
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: Text(
                'Cancel Order',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Color(0xFF121212),
                ),
              ),
              content: Text(
                'Are you sure you want to cancel this order? This action cannot be undone.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF444444),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isLoading ? null : () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No, Keep Order',
                    style: TextStyle(
                      color: isLoading ? Colors.grey : Color(0xFF7A7A7A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: isLoading ? null : () async {
                    setDialogState(() {
                      isLoading = true;
                    });

                    try {
                      bool success = await orderData.cancelOrder(orderData.selectedOrderModel.orderId);
                      
                      if (mounted) {
                        Navigator.of(context).pop(); // Close dialog
                        
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Order cancelled successfully'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to cancel order. Please try again.'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      if (mounted) {
                        Navigator.of(context).pop(); // Close dialog
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('An error occurred. Please try again.'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: isLoading 
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Cancelling...',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Yes, Cancel Order',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
