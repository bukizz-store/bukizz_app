import 'dart:math';

import 'package:bukizz/data/repository/order_view_repository.dart';
import 'package:bukizz/data/repository/payments/upi_payments.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/tick_screen/tick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../constants/colors.dart';
import '../../../../../data/repository/cart_view_repository.dart';
import '../../../../../widgets/circle/custom circleAvatar.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';
import 'package:upi_india/upi_india.dart';

class Checkout3 extends StatefulWidget {
  static const String route = '/checkout3';
  const Checkout3({super.key});

  @override
  State<Checkout3> createState() => _Checkout3State();
}

class _Checkout3State extends State<Checkout3> {
  String selectedUpiProvider = "google_pay";
  bool drop_down = true;
  bool upi = true;
  bool cod = true;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    context.read<UPIPayment>().getUPIapps();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    var orderData = context.read<OrderViewRespository>();
    var cartData = context.watch<CartViewRepository>();
    return Consumer<UPIPayment>(
      builder: (context, upiPayment, child) {

        return Scaffold(
          appBar: AppBar(
            title: Text('Payments'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: dimensions.height8 * 1.5,
                ),
                //container with step 1 2 3
                Container(
                  width: dimensions.screenWidth,
                  height: dimensions.height8 * 11.5,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensions.width24 * 1.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomCircleAvatar(
                          radius: dimensions.height8 * 2,
                          backgroundColor: Color(0xFF058FFF),
                          borderColor: Colors.black38,
                          borderWidth: 0.10,
                          child: ReusableText(
                            text: '1',
                            fontSize: 16,
                            color: Colors.white,
                            height: null,
                          ),
                        ),
                        Container(
                          width: 18.w,
                          height: 1.0,
                          color: Color(0xFFA5A5A5),
                        ),
                        CustomCircleAvatar(
                          radius: dimensions.height8 * 2,
                          backgroundColor: Color(0xFF058FFF),
                          borderColor: Colors.transparent,
                          borderWidth: 0.5,
                          text: 'Summary',
                          child: ReusableText(
                              text: '2', fontSize: 16, color: Colors.white),
                        ),
                        Container(
                          width: 18.w,
                          height: 1.0,
                          color: Color(0xFFA5A5A5),
                        ),
                        CustomCircleAvatar(
                          radius: dimensions.height8 * 2,
                          backgroundColor: Color(0xFF058FFF),
                          borderColor: Colors.black,
                          borderWidth: 0.5,
                          fontWeight: FontWeight.w700,
                          text: 'Payment',
                          child: ReusableText(
                            text: '3',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: dimensions.height8 * 1.5,
                ),

                //container with price detail
                Container(
                  width: dimensions.screenWidth,
                  height: dimensions.height8 * 6.5,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: dimensions.width24,
                        top: dimensions.height8 * 2,
                        right: dimensions.width24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  drop_down = !drop_down;
                                  print(drop_down);
                                });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    ReusableText(
                                      text: 'Total amount',
                                      fontSize: 16,
                                      color: Color(0xFF282828),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    Icon(
                                      drop_down
                                          ? Icons.arrow_drop_down
                                          : Icons.arrow_drop_up,
                                      color: Color(0xFF282828),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            ReusableText(
                              text: '₹${cartData.getSalePrice + 40}',
                              fontSize: 20,
                              color: Color(0xFF121212),
                              fontWeight: FontWeight.w700,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                if (!drop_down)
                  Container(
                    width: dimensions.screenWidth,
                    height: dimensions.height29 * 6.3,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: dimensions.width24,
                          vertical: dimensions.height8 * 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: 'Price Detailes',
                            fontSize: 16,
                            color: Color(0xFF282828),
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: dimensions.height8 * 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReusableText(
                                text: 'Price (${cartData.cart_val} items)',
                                fontSize: 12,
                                color: Color(0xFF7A7A7A),
                                fontWeight: FontWeight.w500,
                              ),
                              ReusableText(
                                text: '₹${cartData.getTotalPrice}',
                                fontSize: 12,
                                color: Color(0xFF121212),
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ),
                          SizedBox(
                            height: dimensions.height8 * 2.5,
                          ),
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
                                    '-₹${cartData.getTotalPrice - cartData.getSalePrice}',
                                fontSize: 12,
                                color: Color(0xFF038B10),
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ),
                          SizedBox(
                            height: dimensions.height8 * 2.5,
                          ),
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
                          Container(
                            width: dimensions.width24 * 14,
                            height: 1,
                            color: Color(0xFFD6D6D6),
                          ),
                          SizedBox(
                            height: dimensions.height8 * 2.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ReusableText(
                                  text: 'Total Amount',
                                  fontSize: 14,
                                  color: Color(0xFF282828),
                                  fontWeight: FontWeight.w700),
                              ReusableText(
                                text: '₹${cartData.getSalePrice + 40}',
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
                            width: dimensions.width24 * 14,
                            height: 1,
                            color: Color(0xFFD6D6D6),
                          ),
                          SizedBox(
                            height: dimensions.height8 * 1.5,
                          ),
                          ReusableText(
                            text:
                                'You will save ₹${cartData.getTotalPrice - cartData.getSalePrice} on this order',
                            fontSize: 12,
                            color: Color(0xFF038B10),
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ),

                SizedBox(
                  height: dimensions.height8 * 1.5,
                ),

                //upi
                // Container(
                //   height: dimensions.height24 * 2,
                //   margin: EdgeInsets.symmetric(horizontal: dimensions.width24),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         children: [
                //           SvgPicture.asset('assets/checkout/upi.svg'),
                //           SizedBox(
                //             width: dimensions.width24 / 3,
                //           ),
                //           ReusableText(
                //             text: 'UPI',
                //             fontSize: 16,
                //             color: Color(0xFF282828),
                //             fontWeight: FontWeight.w700,
                //           )
                //         ],
                //       ),
                //       GestureDetector(
                //           onTap: () {
                //             setState(() {
                //               upi = !upi;
                //             });
                //           },
                //           child: Icon(upi ? Icons.remove : Icons.add,
                //               color: Color(0xFF282828))),
                //     ],
                //   ),
                // ),

                if (upiPayment.apps.isNotEmpty)
                  // Container(
                  //   width: dimensions.screenWidth,
                  //   // height: dimensions.height10 * 23,
                  //   color: Colors.white,
                  //   margin: EdgeInsets.symmetric(horizontal: dimensions.width24),
                  //   padding:EdgeInsets.only(right: dimensions.width16),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       // UPI Provider Selection
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Radio(
                  //                 value: 'google_pay',
                  //                 groupValue: selectedUpiProvider,
                  //                 onChanged: (value) {
                  //                   setState(() {
                  //                     selectedUpiProvider = value.toString();
                  //                   });
                  //                 },
                  //               ),
                  //               ReusableText(
                  //                 text: 'Google Pay',
                  //                 fontSize: 16,
                  //                 color:Color(0xFF282828),
                  //                 fontWeight: FontWeight.w500,
                  //               ),
                  //             ],
                  //
                  //           ),
                  //           Image.asset('assets/payment/gpay.jpg')
                  //         ],
                  //       ),
                  //       if(selectedUpiProvider=='google_pay')
                  //         SizedBox(height: dimensions.height8*1.5,),
                  //       if(selectedUpiProvider=='google_pay')
                  //         Center(
                  //           child: InkWell(
                  //             onTap: (){
                  //               orderData.pushOrderDataToFirebase(context);
                  //               Navigator.pushNamedAndRemoveUntil(context ,  MainScreen.route, (route) => false);
                  //             },
                  //             child: Container(
                  //               alignment: Alignment.center,
                  //               width: dimensions.width24*12.38,
                  //               height: dimensions.height48,
                  //               decoration: ShapeDecoration(
                  //                 color: Color(0xFF058FFF),
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(100),
                  //                 ),
                  //               ),
                  //               child: ReusableText(text: 'Pay ₹${cartData.salePrice + 40}', fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white,),
                  //             ),
                  //           ),
                  //         ),
                  //
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Radio(
                  //                 value: 'phone_pay',
                  //                 groupValue: selectedUpiProvider,
                  //                 onChanged: (value) {
                  //                   setState(() {
                  //                     selectedUpiProvider = value.toString();
                  //                   });
                  //                 },
                  //               ),
                  //               ReusableText(
                  //                 text: 'Phone Pe',
                  //                 fontSize: 16,
                  //                 color: Color(0xFF282828),
                  //                 fontWeight: FontWeight.w500,
                  //               ),
                  //             ],
                  //           ),
                  //           Image.asset('assets/payment/phonepe.jpg')
                  //         ],
                  //       ),
                  //       if(selectedUpiProvider=='phone_pay')
                  //         SizedBox(height: dimensions.height8*1.5,),
                  //
                  //       if(selectedUpiProvider=='phone_pay')
                  //         Center(
                  //           child: InkWell(
                  //             onTap: (){
                  //               orderData.pushOrderDataToFirebase(context);
                  //               Navigator.pushNamedAndRemoveUntil(context ,  MainScreen.route, (route) => false);
                  //             },
                  //             child: Container(
                  //               alignment: Alignment.center,
                  //               width: dimensions.width24*12.38,
                  //               height: dimensions.height48,
                  //               decoration: ShapeDecoration(
                  //                 color: Color(0xFF058FFF),
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(100),
                  //                 ),
                  //               ),
                  //               child: ReusableText(text: 'Pay ₹${cartData.salePrice + 40}', fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white,),
                  //             ),
                  //           ),
                  //         ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //
                  //             children: [
                  //               Radio(
                  //                 value: 'paytm',
                  //                 groupValue: selectedUpiProvider,
                  //                 onChanged: (value) {
                  //                   setState(() {
                  //                     selectedUpiProvider = value.toString();
                  //                   });
                  //                 },
                  //               ),
                  //               ReusableText(
                  //                 text: 'Paytm',
                  //                 fontSize: 16,
                  //                 color: Color(0xFF282828),
                  //                 fontWeight: FontWeight.w500,
                  //               ),
                  //             ],
                  //           ),
                  //           Image.asset('assets/payment/paytm.jpg')
                  //         ],
                  //       ),
                  //
                  //       if(selectedUpiProvider=='paytm')
                  //         SizedBox(height: dimensions.height8*1.5,),
                  //
                  //       if(selectedUpiProvider=='paytm')
                  //         Center(
                  //           child: InkWell(
                  //             onTap: (){
                  //               orderData.pushOrderDataToFirebase(context);
                  //               Navigator.pushNamedAndRemoveUntil(context ,  MainScreen.route, (route) => false);
                  //             },
                  //             child: Container(
                  //               alignment: Alignment.center,
                  //               width: dimensions.width24*12.38,
                  //               height: dimensions.height48,
                  //               decoration: ShapeDecoration(
                  //                 color: Color(0xFF058FFF),
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(100),
                  //                 ),
                  //               ),
                  //               child: ReusableText(text: 'Pay ₹${cartData.salePrice + 40}', fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white,),
                  //             ),
                  //           ),
                  //         ),
                  //
                  //     ],
                  //   ),
                  // ),

                  //listview builder for the data of upiPayment.apps with the same ui as this upper container have
                  // if (upiPayment.apps.isNotEmpty)
                  //   Container(
                  //     width: dimensions.screenWidth,
                  //     height: dimensions.height8 * 23,
                  //     color: Colors.white,
                  //     margin:
                  //         EdgeInsets.symmetric(horizontal: dimensions.width24),
                  //     padding: EdgeInsets.only(right: dimensions.width16),
                  //     child: ListView.builder(
                  //       itemCount: upiPayment.apps!.length,
                  //       itemBuilder: (context, index) {
                  //         return Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             // UPI Provider Selection
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Row(
                  //                   children: [
                  //                     Radio(
                  //                       value: upiPayment.apps[index].name,
                  //                       groupValue: selectedUpiProvider,
                  //                       onChanged: (value) {
                  //                         setState(() {
                  //                           selectedUpiProvider =
                  //                               value.toString();
                  //                         });
                  //                       },
                  //                     ),
                  //                     ReusableText(
                  //                       text: upiPayment.apps[index].name,
                  //                       fontSize: 16,
                  //                       color: Color(0xFF282828),
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 Image.memory(
                  //                   upiPayment.apps[index].icon,
                  //                   width: dimensions.width24 * 3,
                  //                   height: dimensions.height8 * 3,
                  //                   fit: BoxFit.cover,
                  //                   filterQuality: FilterQuality.high,
                  //                   cacheHeight: 100,
                  //                   cacheWidth: 100,
                  //                   errorBuilder:
                  //                       (context, error, stackTrace) =>
                  //                           Icon(Icons.error),
                  //                 ),
                  //               ],
                  //             ),
                  //             if (selectedUpiProvider ==
                  //                 upiPayment.apps[index].name)
                  //               SizedBox(
                  //                 height: dimensions.height8 * 1.5,
                  //               ),
                  //             if (selectedUpiProvider ==
                  //                 upiPayment.apps[index].name)
                  //               Center(
                  //                 child: InkWell(
                  //                   onTap: () async{
                  //                     upiPayment.setTransactionRefId(generateTransactionId());
                  //                     upiPayment.setTransactionNote(orderData.orderName);
                  //                     upiPayment.setAmount(orderData.saleAmount);
                  //                     await upiPayment.initiateTransaction(upiPayment.apps[index] , context);
                  //                   },
                  //                   child: Container(
                  //                     alignment: Alignment.center,
                  //                     width: dimensions.width24 * 12.38,
                  //                     height: dimensions.height48,
                  //                     decoration: ShapeDecoration(
                  //                       color: AppColors.productButtonSelectedBorder,
                  //                       shape: RoundedRectangleBorder(
                  //                         borderRadius:
                  //                             BorderRadius.circular(100),
                  //                       ),
                  //                     ),
                  //                     child: ReusableText(
                  //                       text:
                  //                           'Pay ₹${cartData.getSalePrice + 40}',
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.w700,
                  //                       color: Colors.white,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //           ],
                  //         );
                  //       },
                  //     ),
                  //   ),

                SizedBox(height: dimensions.height10,),
                Container(
                  height: dimensions.height24 * 2,
                  margin: EdgeInsets.symmetric(horizontal: dimensions.width24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.money),
                          SizedBox(
                            width: dimensions.width24 / 3,
                          ),
                          ReusableText(
                            text: 'Cash on Delivery',
                            fontSize: 16,
                            color: Color(0xFF282828),
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              cod = !cod;
                            });
                          },
                          child: Icon(cod ? Icons.remove : Icons.add,
                              color: Color(0xFF282828))
                      ),


                    ],
                  ),
                ),
                if(cod)
                  Center(
                    child: InkWell(
                      onTap:  () {
                        showCustomAboutDialog(context ,(){
                          context.read<OrderViewRespository>().setOrderModelData("cod_${generateTransactionId()}" , context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const TickScreen(
                                      text: "Ordered Successfully",
                                      secondaryText: "Your order has been placed successfully")));
                        });
                      },
                      child: Container(
                        
                        alignment: Alignment.center,
                        width: dimensions.width24 * 12.38,
                        height: dimensions.height48,
                        decoration: BoxDecoration(
                            color: AppColors.productButtonSelectedBorder,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: const [
                              BoxShadow(
                                color:Color(0xFF0466b5),
                                offset:Offset(0,4),

                              )
                            ]
                        ),
                        child: ReusableText(
                          text:
                          'Pay ₹${cartData.getSalePrice + 40}',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

              ],
            ),
          ),
        );
      },
    );
  }



  String generateTransactionId() {
    // Get current timestamp
    DateTime now = DateTime.now();

    // Generate a random number between 1000 and 9999
    int random = Random().nextInt(9000) + 1000;

    // Format the timestamp as string (you can customize the format as needed)
    String timestamp = '${now.microsecondsSinceEpoch}';

    // Combine the timestamp and random number to create a unique transaction ID
    String transactionId = '${timestamp}_$random';

    return transactionId;
  }
}

void showCustomAboutDialog(BuildContext context , Function onTap) {
  Dimensions dimensions=Dimensions(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          title: Center(
            child: ReusableText(text: 'Confirm Cash on Delivery Option', fontSize: 16,fontWeight: FontWeight.w700,color: Color(0xFF121212),),
          ),
          content:Container(
            // width: dimensions.width10*35.6,
            height: dimensions.height10*15.5,
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  width: dimensions.width10*9.6,
                  height: dimensions.height10*6.4,
                  child: Image.asset('assets/payment/cod.jpg',),
                ),
                SizedBox(height: dimensions.height10,),
                SizedBox(
                  width: dimensions.width10*29.4,
                  child: const Text(
                    'You can pay at the time of delivery via Cash/UPI or ATM Card.',
                    textAlign: TextAlign.center,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: dimensions.width10*11.5,
                        height: dimensions.height10*3.5,
                        decoration: ShapeDecoration(
                          color: Color(0xFF058FFF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        child: Center(
                          child: ReusableText(text: 'Cancel', fontSize: 14,fontWeight: FontWeight.w600, color:Colors.white,),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        onTap();
                        },
                      child: Container(
                        width: dimensions.width10*11.5,
                        height: dimensions.height10*3.5,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.50, color: Color(0xFF00579E)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Center(
                          child: ReusableText(text: 'Confirm Order', fontSize: 14,fontWeight: FontWeight.w600, color: Color(0xFF00579E),),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )

      );

    },
  );
}
