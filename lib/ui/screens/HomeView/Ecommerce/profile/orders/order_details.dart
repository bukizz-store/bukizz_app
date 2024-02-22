import 'package:bukizz/data/repository/my_orders.dart';
import 'package:bukizz/data/repository/query/order_query.dart';
import 'package:bukizz/data/repository/review/review_repository.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/add_rating.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/queryContact/contact_for_query.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../constants/font_family.dart';
import '../../../../../../data/models/ecommerce/products/product_model.dart';
import '../../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../../../utils/dimensions.dart';
import '../../main_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const route = '/orderdetails';
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int itemCount = 2;
  bool dropDown = false;
  @override
  Widget build(BuildContext context) {
    BottomNavigationBarProvider provider =
        context.read<BottomNavigationBarProvider>();
    Dimensions dimensions = Dimensions(context);
    return Consumer<MyOrders>(builder: (context, orderData, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
        ),
        body: orderData.isOrderDataLoaded? SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: dimensions.height16,
                color:Color(0xFFF5FAFF),
              ),
              Column(
                children: [
                  Container(
                    width: dimensions.screenWidth,
                    height: dimensions.height10 * 11.3,
                    padding: EdgeInsets.only(
                        left: dimensions.width16, top: dimensions.height10),
                    color: Colors.white,
                    child: Row(
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
                            child: SvgPicture.asset(
                              'assets/school/booksets/1.svg',
                              fit: BoxFit.cover,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(width: dimensions.width16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: dimensions.height10,
                            ),
                            ReusableText(
                                text:
                                    '${orderData.selectedOrderModel.cartLength} items',
                                fontSize: 12),
                            SizedBox(
                              height: dimensions.height10,
                            ),
                            SizedBox(
                              // width: dimensions.width10 * 25.2,
                              child: Text(
                                'Your product ${orderData.selectedOrderModel.orderName} is delivered',
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
                              height: dimensions.height10,
                            ),
                            ReusableText(
                              text:
                                  'Ordered On: ${orderData.selectedOrderModel.orderDate.substring(0, 10)}',
                              fontSize: 12,
                              color: Color(0xFFA5A5A5),
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: dimensions.screenWidth,
                      height: dimensions.height10 * 23 * itemCount,
                      color: Colors.white,
                      // child:ListView.builder(
                      //     itemCount: itemCount,
                      //     physics: NeverScrollableScrollPhysics(),
                      //     scrollDirection: Axis.vertical,
                      //     itemBuilder:(context,index){
                      // return Padding(
                      //   padding: EdgeInsets.symmetric(horizontal:dimensions.height8*2,vertical: dimensions.width10*1.8),
                      //   child: Container(
                      //     width: dimensions.width10*39.3,
                      //     // height: dimensions.height10*20,
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Row(
                      //           children: [
                      //             ReusableText(text: 'Your order is', fontSize: 16,color: Color(0xFF444444),fontWeight: FontWeight.w700,),
                      //             SizedBox(width: dimensions.width10/2,),
                      //             ReusableText(text: 'Delivered', fontSize: 16,color: Color(0xFF444444),fontWeight: FontWeight.w700,),
                      //           ],
                      //         ),
                      //         SizedBox(height: dimensions.height8*2,),
                      //         ReusableText(text: '1 Day ago', fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFF7A7A7A),),
                      //         SizedBox(height: dimensions.height8*2,),
                      //         Row(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(
                      //               width: dimensions.width10 * 7.6,
                      //               height: dimensions.height10 * 7.6,
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(
                      //                   dimensions.width10 ,
                      //                 ),
                      //
                      //               ),
                      //               child: ClipRRect(
                      //                 borderRadius: BorderRadius.circular(
                      //                   dimensions.width10 ,
                      //                 ),
                      //                 child: SvgPicture.asset(
                      //                   'assets/school/booksets/${index + 1}.svg',
                      //                   fit: BoxFit.cover,
                      //                   color: Colors.red,
                      //                 ),
                      //               ),
                      //             ),
                      //
                      //             SizedBox(width: dimensions.width16,),
                      //             Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 SizedBox(
                      //                   width: dimensions.width10*25.2,
                      //                   child: const Text(
                      //                     'Your product English Book Set - Wisdom World School - Class 1st is delivered',
                      //                     style: TextStyle(
                      //                       color: Color(0xFF444444),
                      //                       fontSize: 12,
                      //                       fontFamily: 'Nunito',
                      //                       fontWeight: FontWeight.w400,
                      //                       height: 0,
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: dimensions.height16,),
                      //                 ReusableText(text: '₹ 240', fontSize: 12,fontWeight: FontWeight.w700,color: Color(0xFF121212),)
                      //               ],
                      //             ),
                      //
                      //           ],
                      //         ),
                      //         SizedBox(height: dimensions.height8*2,),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             OutlinedButton(
                      //               onPressed: () {
                      //                 Navigator.pushNamed(context, KnowMoreScreen.route);
                      //               },
                      //               style: OutlinedButton.styleFrom(
                      //                   shape: const RoundedRectangleBorder(
                      //                     side: BorderSide(color: Color(0xFF7A7A7A) ),
                      //                   ),
                      //                   padding: EdgeInsets.symmetric(horizontal: dimensions.width10*4)
                      //               ),
                      //               child: ReusableText(
                      //                 text: 'Contact Us',
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w600,
                      //                 color: Color(0xFF7A7A7A),
                      //               ),
                      //             ),
                      //             OutlinedButton(
                      //               onPressed: () {
                      //                 Navigator.pushNamed(context, RatingsScreen.route);
                      //               },
                      //               style: OutlinedButton.styleFrom(
                      //
                      //                 shape: const RoundedRectangleBorder(
                      //                   side: BorderSide(color: Color(0xFF7A7A7A) ),
                      //                 ),
                      //                 padding: EdgeInsets.symmetric(horizontal: dimensions.width10*4),
                      //                 backgroundColor: Color(0xFF058FFF),
                      //
                      //               ),
                      //               child: ReusableText(
                      //                 text: 'Add Review',
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w600,
                      //                 color:Colors.white,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(height: dimensions.height10*2,),
                      //         Container(
                      //           width: dimensions.screenWidth,
                      //           height: 1,
                      //           color: Color(0xFFD6D6D6),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // );

                      //   return _buildWidget(orderData, context, dimensions);
                      // }
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children:
                                _buildWidget(orderData, context, dimensions),
                          ),
                        ),
                      )),
                ],
              ),

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
                    Row(
                      children: [
                        ReusableText(
                          text: 'Total Amount',
                          fontSize: 16,
                          color: Color(0xFF282828),
                          fontWeight: FontWeight.w500,
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                dropDown = !dropDown;
                              });
                            },
                            child: Icon(Icons.arrow_drop_down))
                      ],
                    ),
                    ReusableText(
                      text: '₹${orderData.selectedOrderModel.saleAmount}',
                      fontSize: 16,
                      color: Color(0xFF121212),
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              if (dropDown)
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensions.width16,
                      vertical: dimensions.height16 / 2),
                  width: dimensions.screenWidth,
                  height: null,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //1st product
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SizedBox(
                      //       width: dimensions.width10*26.4,
                      //       child: const Text(
                      //         'English Book Set - Wisdom World School - Class 1st, Stationary Kit, School Bag, Wisdom world school',
                      //         style: TextStyle(
                      //             color: Color(0xFF7A7A7A),
                      //             fontSize: 12,
                      //             fontFamily: 'Nunito',
                      //             fontWeight: FontWeight.w500,
                      //             height: 0,
                      //             overflow: TextOverflow.ellipsis
                      //         ),
                      //       ),
                      //     ),
                      //     ReusableText(text: '₹2080', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500, )
                      //   ],
                      // ),
                      // SizedBox(height: dimensions.height8,),

                      //2nd product
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SizedBox(
                      //       width: dimensions.width10*26.4,
                      //       child: const Text(
                      //         'Notebook Set',
                      //         style: TextStyle(
                      //             color: Color(0xFF7A7A7A),
                      //             fontSize: 12,
                      //             fontFamily: 'Nunito',
                      //             fontWeight: FontWeight.w500,
                      //             height: 0,
                      //             overflow: TextOverflow.ellipsis
                      //         ),
                      //       ),
                      //     ),
                      //     ReusableText(text: '₹2080', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500, )
                      //   ],
                      // ),
                      // SizedBox(height: dimensions.height8,),

                      //3rd
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     SizedBox(
                      //       width: dimensions.width10*26.4,
                      //       child: const Text(
                      //         'Uniform',
                      //         style: TextStyle(
                      //             color: Color(0xFF7A7A7A),
                      //             fontSize: 12,
                      //             fontFamily: 'Nunito',
                      //             fontWeight: FontWeight.w500,
                      //             height: 0,
                      //             overflow: TextOverflow.ellipsis
                      //         ),
                      //       ),
                      //     ),
                      //     ReusableText(text: '₹2080', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500, )
                      //   ],
                      // ),
                      // SizedBox(height: dimensions.height8,),

                      //total price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: dimensions.width10 * 26.4,
                            child: Text(
                              'Price(${orderData.selectedOrderModel.cartLength} items)',
                              style: const TextStyle(
                                  color: Color(0xFF7A7A7A),
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          ReusableText(
                            text:
                                '₹${orderData.selectedOrderModel.totalAmount}',
                            fontSize: 12,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: 'Discount',
                            fontSize: 12,
                            color: Color(0xFF7A7A7A),
                            fontWeight: FontWeight.w500,
                          ),
                          ReusableText(
                              text:
                                  '-₹${orderData.selectedOrderModel.totalAmount - orderData.selectedOrderModel.saleAmount}',
                              fontSize: 12,
                              color: Color(0xFF038B10),
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2.5,
                      ),
                      //delivery charges
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: 'Delivery Charges',
                            fontSize: 12,
                            color: Color(0xFF7A7A7A),
                            fontWeight: FontWeight.w500,
                          ),
                          ReusableText(
                            text: '₹40',
                            fontSize: 12,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: 'Total Amount',
                            fontSize: 14,
                            color: Color(0xFF282828),
                            fontWeight: FontWeight.w700,
                          ),
                          ReusableText(
                            text:
                                '₹${orderData.selectedOrderModel.totalAmount}',
                            fontSize: 12,
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
                        text: 'You will save ₹40 on this order',
                        fontSize: 12,
                        color: Color(0xFF038B10),
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),

              SizedBox(
                height: dimensions.height24 * 2,
              ),
            ],
          ),
        ) : Center(child: SpinKitChasingDots(size: 24 ,),),
      );
    });
  }

  String setProductName(
      String school, int set, int stream, ProductModel product) {
    String streamName = product.stream.isNotEmpty
        ? "- ${product.stream[stream].name}" ?? ''
        : '';
    String setName =
        product.set.isNotEmpty ? "(${product.set[set].name})" ?? '' : '';
    return "$school - ${product.name}$streamName $setName";
  }

  int setTotalSalePrice(ProductModel product, int set, int stream) {
    int totalSalePrice = product.salePrice;
    product.set.isNotEmpty
        ? totalSalePrice += int.parse(product.set[set].price)
        : 0;
    product.stream.isNotEmpty
        ? totalSalePrice += int.parse(product.stream[stream].price ?? "0")
        : 0;
    return totalSalePrice;
  }

  int setTotalPrice(ProductModel product, int set, int stream) {
    int totalPrice = product.price.floor();
    product.set.isNotEmpty
        ? totalPrice += int.parse(product.set[set].price)
        : 0;
    product.stream.isNotEmpty
        ? totalPrice += int.parse(product.stream[stream].price ?? "0")
        : 0;
    return totalPrice;
  }

  List<Widget> _buildWidget(
      MyOrders orderData, BuildContext context, dimensions) {
    List<Widget> list = [];
    // totalPrice = 0;
    // salePrice = 0;
    if(orderData.isOrderDataLoaded) {
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
              // totalPrice += price * quantity;
              // salePrice += totalSalePrice * quantity;
              list.add(Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: dimensions.height8 * 2,
                    vertical: dimensions.width10 * 1.8),
                child: Container(
                  width: dimensions.width10 * 39.3,
                  // height: dimensions.height10*20,
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
                        color: Color(0xFF7A7A7A),
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
                              child: SvgPicture.asset(
                                'assets/school/booksets/${1}.svg',
                                fit: BoxFit.cover,
                                color: Colors.red,
                              ),
                            ),
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
                                  'Your product $productName is delivered',
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
                                text: '₹ $price',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF121212),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: dimensions.height8 * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              //Sending Initial data to orderQuery Repository
                              context
                                  .read<OrderQueryRepository>()
                                  .setInitialData(
                                      orderData.selectedOrderModel.orderId,
                                      productName,
                                      orderData
                                          .selectedOrderModel.address.phone);
                              Navigator.pushNamed(
                                  context, KnowMoreScreen.route);
                            },
                            style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Color(0xFF7A7A7A)),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: dimensions.width10 * 4)),
                            child: ReusableText(
                              text: 'Contact Us',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7A7A7A),
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
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xFF7A7A7A)),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: dimensions.width10 * 4),
                              backgroundColor: Color(0xFF058FFF),
                            ),
                            child: ReusableText(
                              text: 'Add Review',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
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
}
