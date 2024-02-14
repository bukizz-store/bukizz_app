import 'package:bukizz/data/repository/my_orders.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/add_rating.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/queryContact/contact_for_query.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/profile/orders/order_details.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../constants/font_family.dart';
import '../../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../../../utils/dimensions.dart';
import 'package:shimmer/shimmer.dart';

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
          title: const Text('My Orders'),
        ),
        body:
          SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: dimensions.height16,
                color: Color(0xFFE0F0FF),
              ),
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: dimensions.width16/2,),
                      width: dimensions.screenWidth,
                      height: dimensions.height10 *
                          20 *
                          (4),
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount:orderData.orders.length,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: dimensions.height8,
                                  ),
                              child: Container(
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
                                            child: SvgPicture.asset(
                                              'assets/school/booksets/${index + 1}.svg',
                                              fit: BoxFit.cover,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: dimensions.width16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: dimensions.height8,),
                                            ReusableText(text: '${orderData.orders[index].cartLength} items', fontSize: 12),
                                            SizedBox(height: dimensions.height10,),
                                            SizedBox(
                                              width: dimensions.width10 * 25.2,
                                              child: Text(
                                                orderData.orders[index].orderName,
                                                style: TextStyle(
                                                  color: Color(0xFF444444),
                                                  fontSize: 12,
                                                  fontFamily: 'Nunito',
                                                  fontWeight: FontWeight.w400,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: dimensions.height10,),
                                            ReusableText(text: 'Ordered On: ${orderData.orders[index].orderDate.substring(0,10)}', fontSize: 12,color: Color(0xFFA5A5A5),fontWeight: FontWeight.w500,),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: dimensions.height8 * 3),
                                    GestureDetector(
                                      onTap: (){
                                        orderData.setOrder(index);
                                        Navigator.pushNamed(context, OrderDetailsScreen.route);
                                      },
                                      child: Container(
                                        width: dimensions.width10*34.5,
                                        height: dimensions.height10*3.5,
                                        padding: const EdgeInsets.all(8),
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(width: 0.50, color: Color(0xFF7A7A7A)),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ReusableText(text:  'View Order', fontSize: 14,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w600,)
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
                              ),
                            );
                          })),
                  SizedBox(height: dimensions.height40*2,)
                ],
              ),
            ],
          ),
        )

      ) : Center(child: CircularProgressIndicator(),);
    });
  }
}

