import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/data/repository/my_orders.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/orders/order_details.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../../../utils/dimensions.dart';

// Import your other dependencies

class OrderScreen extends StatefulWidget {
  static const route = '/order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int itemCount = 2;

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarProvider provider =
    context.read<BottomNavigationBarProvider>();
    Dimensions dimensions = Dimensions(context);
    return Consumer<MyOrders>(builder: (context, orderData, child) {
      return orderData.isOrdersLoaded? Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),onPressed: (){Navigator.of(context).pop();},),
            title: ReusableText(text: 'My Orders',fontSize: 20,fontWeight: FontWeight.w500,),
          ),
        body:
          SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: dimensions.height16,
                color: Color(0xFFF5FAFF),
              ),
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: dimensions.width16/2,),
                      width: dimensions.screenWidth,
                      height: dimensions.height10 *
                          18.6*
                          (orderData.orders.length),
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount:orderData.orders.length,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                              width: dimensions.width10 * 39.3,
                              // height: dimensions.height10 * 20,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: dimensions.height24,),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: dimensions.width10 * 7.6,
                                        height: dimensions.height10 * 7.6,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                            dimensions.width10,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(
                                            dimensions.width10,
                                          ),
                                          child: Image.asset('assets/orders.png')
                                        ),
                                      ),
                                      SizedBox(width: dimensions.width16),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: dimensions.height8,),
                                          Row(
                                            children: [
                                              ReusableText(text: 'Order Status : ', fontSize: 18),
                                              SizedBox(
                                                width: 35.w,
                                                child: Text(
                                                  orderData.orders[index].status,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'nunito',
                                                    fontSize: 16,
                                                    overflow: TextOverflow.ellipsis,
                                                    color: Color(0xFF00AE11)
                                                  ),
                                                  maxLines: 1, // Adjust max lines as needed
                                                  softWrap: false, // Ensure no soft wrapping
                                                ),
                                              )

                                            ],
                                          ),
                                          SizedBox(height: dimensions.height16,),
                                          ReusableText(text: '${orderData.orders[index].cartLength} items', fontSize: 14,),
                                          SizedBox(height: dimensions.height10,),
                                          SizedBox(
                                            width: dimensions.width10 * 25.2,
                                            child: Row(
                                              children: [
                                                ReusableText(
                                                  text: 'Order ID: ',
                                                  fontSize: 14,
                                                  color: Color(0xFFA5A5A5),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                Text(
                                                  orderData.orders[index].orderId.split('-')[0],
                                                  style: const TextStyle(
                                                    color: Color(0xFF444444),
                                                    fontSize: 14,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w400,
                                                    height: 0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: dimensions.height10,),
                                          Row(
                                            children: [
                                              ReusableText(text: 'Ordered On: ', fontSize: 12,color: Color(0xFFA5A5A5),fontWeight: FontWeight.w500,),
                                              ReusableText(text: orderData.orders[index].orderDate.substring(0,10), fontSize: 12,color: Color(0xFF444444),fontWeight: FontWeight.w400,),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: dimensions.height8 * 3),
                                  GestureDetector(
                                    onTap: () {
                                      orderData.setOrder(index);
                                      Navigator.pushNamed(context, OrderDetailsScreen.route);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: dimensions.height16,
                                        vertical: 4
                                      ),
                                      width: dimensions.screenWidth,
                                      height: dimensions.height10 * 3.5,

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(width: 0.5, color: Colors.blueGrey),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius:0.6,
                                            blurRadius: 18,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.visibility,
                                            color: Color(0xFF7A7A7A),
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'View Order',
                                            style: TextStyle(
                                              color: Color(0xFF7A7A7A),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'nunito'
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: dimensions.height10*2),
                                  Container(
                                    width: dimensions.screenWidth,
                                    height: 0.5,
                                    color: Color(0xFFD6D6D6),
                                  ),
                                  // SizedBox(height: dimensions.height40,)
                                ],
                              ),
                            );
                          })),
                  SizedBox(height: dimensions.height40*2,)
                ],
              ),
            ],
          ),
        )

      ) : const Scaffold(body: Center(child: SpinKitChasingDots(color: AppColors.primaryColor, size: 24,),));
    });
  }
}

