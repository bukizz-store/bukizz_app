
import 'package:bukizz/data/repository/order_view_repository.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/font_family.dart';
import '../../../../../data/repository/cart_view_repository.dart';
import '../../../../../widgets/circle/custom circleAvatar.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';
import '../../homeScreen.dart';

class Checkout3 extends StatefulWidget {
  const Checkout3({super.key});

  @override
  State<Checkout3> createState() => _Checkout3State();
}

class _Checkout3State extends State<Checkout3> {
  String selectedUpiProvider = "google_pay";
  bool drop_down=true;
  bool upi=true;

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    var orderData = context.read<OrderViewRespository>();
    var cartData = context.watch<CartViewRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: dimensions.height8*1.5,),

            //container with step 1 2 3
            Container(
              width: dimensions.screenWidth,
              height: dimensions.height8*11.5,
              color: Colors.white,
              child:Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensions.width24*1.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Color(0xFF058FFF),
                      borderColor: Colors.black38,
                      borderWidth: 0.10,
                      child: ReusableText(text: '1', fontSize: 16,color: Colors.white, height: null,),
                    ),
                    Container(
                      width: 90.0,
                      height: 1.0,
                      color: Color(0xFFA5A5A5),
                    ),
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Color(0xFF058FFF),
                      borderColor: Colors.black,
                      borderWidth: 0.5,
                      child: ReusableText(text: '2', fontSize: 16,color: Colors.white),
                    ),
                    Container(
                      width: 90.0,
                      height: 1.0,
                      color: Color(0xFFA5A5A5),
                    ),
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Color(0xFF058FFF),
                      borderColor: Colors.black,
                      borderWidth: 0.5,
                      child: ReusableText(text: '3', fontSize: 16,color: Colors.white,),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: dimensions.height8*1.5,),

            //container with price detail
            Container(
              width: dimensions.screenWidth,
              height: dimensions.height8*6.5,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: dimensions.width24,top: dimensions.height8*2,right:dimensions.width24 ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              drop_down=!drop_down;
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
                                  drop_down ? Icons.arrow_drop_down : Icons.arrow_drop_up,
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
                height: dimensions.height29*6.3,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height8*2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(text: 'Price Detailes', fontSize: 16,color: Color(0xFF282828),fontWeight: FontWeight.w700,),
                      SizedBox(height: dimensions.height8*3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(text: 'Price (${cartData.cart_val} items)', fontSize: 12,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w500,),
                          ReusableText(text: '₹${cartData.getTotalPrice}', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500,)
                        ],
                      ),
                      SizedBox(height: dimensions.height8*2.5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(text: 'Discount', fontSize: 12,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w500,),
                          ReusableText(text: '-₹${cartData.getTotalPrice - cartData.getSalePrice}', fontSize: 12,color: Color(0xFF038B10),fontWeight: FontWeight.w500,)
                        ],
                      ),
                      SizedBox(height: dimensions.height8*2.5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(text: 'Delivery Charges', fontSize: 12,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w500,),
                          ReusableText(text: '₹40', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500,)
                        ],
                      ),
                      SizedBox(height: dimensions.height8*1.5,),
                      Container(
                        width: dimensions.width24*14,
                        height: 1,
                        color: Color(0xFFD6D6D6),
                      ),
                      SizedBox(height: dimensions.height8*2.5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(text: 'Total Amount', fontSize: 14,color: Color(0xFF282828),fontWeight: FontWeight.w700),
                          ReusableText(text: '₹${cartData.getSalePrice + 40}', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500,)
                        ],
                      ),
                      SizedBox(height: dimensions.height8*1.5,),
                      Container(
                        width: dimensions.width24*14,
                        height: 1,
                        color: Color(0xFFD6D6D6),
                      ),
                      SizedBox(height: dimensions.height8*1.5,),
                      ReusableText(text: 'You will save ₹${cartData.getTotalPrice - cartData.getSalePrice} on this order', fontSize: 12,color: Color(0xFF038B10),fontWeight: FontWeight.w600,)
                    ],
                  ),
                ),
              ),

            SizedBox(height: dimensions.height8*1.5,),

           //upi
           Container(
             height: dimensions.height24*2,
             margin: EdgeInsets.symmetric(horizontal: dimensions.width24),
             child:Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Row(
                   children: [
                     SvgPicture.asset('assets/checkout/upi.svg'),
                     SizedBox(width: dimensions.width24/3,),
                     ReusableText(text: 'UPI', fontSize: 16,color: Color(0xFF282828),fontWeight: FontWeight.w700,)
                   ],
                 ),
                 GestureDetector(
                     onTap: (){
                       setState(() {
                         upi=!upi;
                       });
                     },
                     child: Icon(upi?Icons.remove:Icons.add,color: Color(0xFF282828))
                 ),
               ],
             ),
           ),

           if(upi)
             Container(
               width: dimensions.screenWidth,
               // height: dimensions.height10 * 23,
               color: Colors.white,
               margin: EdgeInsets.symmetric(horizontal: dimensions.width24),
               padding:EdgeInsets.only(right: dimensions.width16),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   // UPI Provider Selection
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(
                         children: [
                           Radio(
                             value: 'google_pay',
                             groupValue: selectedUpiProvider,
                             onChanged: (value) {
                               setState(() {
                                 selectedUpiProvider = value.toString();
                               });
                             },
                           ),
                           ReusableText(
                             text: 'Google Pay',
                             fontSize: 16,
                             color:Color(0xFF282828),
                             fontWeight: FontWeight.w500,
                           ),
                         ],
                         
                       ),
                       Image.asset('assets/payment/gpay.jpg')
                     ],
                   ),
                   if(selectedUpiProvider=='google_pay')
                    SizedBox(height: dimensions.height8*1.5,),
                   if(selectedUpiProvider=='google_pay')
                     Center(
                       child: InkWell(
                         onTap: (){
                           orderData.pushOrderDataToFirebase(context);
                           Navigator.pushNamedAndRemoveUntil(context ,  MainScreen.route, (route) => false);
                         },
                         child: Container(
                           alignment: Alignment.center,
                           width: dimensions.width24*12.38,
                           height: dimensions.height48,
                           decoration: ShapeDecoration(
                             color: Color(0xFF058FFF),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(100),
                             ),
                           ),
                           child: ReusableText(text: 'Pay ₹${cartData.salePrice + 40}', fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white,),
                         ),
                       ),
                     ),

                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      Row(
                        children: [
                          Radio(
                            value: 'phone_pay',
                            groupValue: selectedUpiProvider,
                            onChanged: (value) {
                              setState(() {
                                selectedUpiProvider = value.toString();
                              });
                            },
                          ),
                          ReusableText(
                            text: 'Phone Pe',
                            fontSize: 16,
                            color: Color(0xFF282828),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                       Image.asset('assets/payment/phonepe.jpg')
                     ],
                   ),
                   if(selectedUpiProvider=='phone_pay')
                     SizedBox(height: dimensions.height8*1.5,),

                   if(selectedUpiProvider=='phone_pay')
                     Center(
                       child: InkWell(
                         onTap: (){
                           orderData.pushOrderDataToFirebase(context);
                           Navigator.pushNamedAndRemoveUntil(context ,  MainScreen.route, (route) => false);
                         },
                         child: Container(
                           alignment: Alignment.center,
                           width: dimensions.width24*12.38,
                           height: dimensions.height48,
                           decoration: ShapeDecoration(
                             color: Color(0xFF058FFF),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(100),
                             ),
                           ),
                           child: ReusableText(text: 'Pay ₹${cartData.salePrice + 40}', fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white,),
                         ),
                       ),
                     ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(

                         children: [
                           Radio(
                             value: 'paytm',
                             groupValue: selectedUpiProvider,
                             onChanged: (value) {
                               setState(() {
                                 selectedUpiProvider = value.toString();
                               });
                             },
                           ),
                           ReusableText(
                             text: 'Paytm',
                             fontSize: 16,
                             color: Color(0xFF282828),
                             fontWeight: FontWeight.w500,
                           ),
                         ],
                       ),
                       Image.asset('assets/payment/paytm.jpg')
                     ],
                   ),

                   if(selectedUpiProvider=='paytm')
                     SizedBox(height: dimensions.height8*1.5,),

                   if(selectedUpiProvider=='paytm')
                     Center(
                       child: InkWell(
                         onTap: (){
                           orderData.pushOrderDataToFirebase(context);
                           Navigator.pushNamedAndRemoveUntil(context ,  MainScreen.route, (route) => false);
                         },
                         child: Container(
                           alignment: Alignment.center,
                           width: dimensions.width24*12.38,
                           height: dimensions.height48,
                           decoration: ShapeDecoration(
                             color: Color(0xFF058FFF),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(100),
                             ),
                           ),
                           child: ReusableText(text: 'Pay ₹${cartData.salePrice + 40}', fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white,),
                         ),
                       ),
                     ),

                 ],
               ),
             ),


          ],
        ),
      ),
    );
  }
}
