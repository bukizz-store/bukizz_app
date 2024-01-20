import 'package:bukizz_1/constants/font_family.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_TextForm.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/buttons/cart_button.dart';
import '../../../../../widgets/circle/custom circleAvatar.dart';
import '../../../../../widgets/containers/Reusable_ColouredBox.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';
import '../Cart/cart_screen.dart';

class Checkout2 extends StatefulWidget {
  const Checkout2({super.key});

  @override
  State<Checkout2> createState() => _Checkout2State();
}

class _Checkout2State extends State<Checkout2> {
  int cart_val=2;
  String? selectedAddress;
  TextEditingController couponController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order summary'),
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
                      backgroundColor:Colors.transparent,
                      borderColor: Colors.black,
                      borderWidth: 0.5,
                      child: ReusableText(text: '3', fontSize: 16,color: Color(0xFF058FFF),),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: dimensions.height8*1.5,),
            //add new address
            Container(
              width: dimensions.screenWidth,
              height: dimensions.height48,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensions.width24),
                child: InkWell(
                  onTap: (){
                    print('add new address tapped');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add,color:Color(0xFF00589E),),
                      ReusableText(text: 'Add New Address', fontSize: 14,color: Color(0xFF00589E),)
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: dimensions.height8*1.5,),

            //address selection
            Container(
              width: dimensions.screenWidth,
              height: dimensions.height8*12,
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: dimensions.width24/3,vertical: dimensions.height8*1.5),
                  child:Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Radio<String>(
                          value: '2nd floor 1884 sector 8, Sector 8, Kurukshetra, Haryana',
                          groupValue: selectedAddress,
                          onChanged: (value) {
                            setState(() {
                              selectedAddress = value;
                            });
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //deliver to : name
                            Flexible(
                              child: Row(
                                children: [
                                  ReusableText(text: 'Deliver to: ', fontSize: 16,color: Color(0xFF282828),fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis,),
                                  ReusableText(text: 'Aman Saini, 136118', fontSize: 16,color:Color(0xFF121212),fontWeight: FontWeight.w700,overflow: TextOverflow.clip,),
                                ],
                              ),
                            ),

                            SizedBox(height: dimensions.height8*2,),
                            // address with overflow
                            SizedBox(
                              width: dimensions.width24*9.5,
                              child: const Text(
                                '2nd floor 1884 sector 8, Sector 8, Kurukshetra, Haryana',
                                style: TextStyle(
                                    color: Color(0xFF7A7A7A),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                    overflow: TextOverflow.ellipsis
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: dimensions.width16/3,),
                        Padding(
                          padding:  EdgeInsets.only(top: dimensions.height8),
                          child: Container(
                            width: dimensions.width16*4,
                            height: dimensions.height8*4.5,

                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 0.50, color: Color(0xFFD6D6D6)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Center(child: ReusableText(text: 'Change', fontSize: 14,color: Color(0xFF00579E),fontWeight: FontWeight.w600,),),
                          ),
                        ),
                      ]
                  )
              ),
            ),

            SizedBox(height: dimensions.height8*1.5,),

            //cart products
            Column(
              children: List.generate(
                2,
                    (index) =>
                    Container(
                      height: dimensions.height192,
                      width: dimensions.screenWidth,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: dimensions.width24/1.5,
                          vertical: dimensions.height8/2,
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: dimensions.width83,
                                      height: dimensions.height83,
                                      child: Image.asset(images[index]),
                                    ),
                                    SizedBox(height: dimensions.height8),
                                    ReusableQuantityButton(
                                      quantity: CartQuantity[index],
                                      height: 32,
                                      width: 83,
                                      onChanged: (newQuantity) {
                                        setState(() {
                                          CartQuantity[index] = newQuantity;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: dimensions.height16,),

                                    //book names
                                    SizedBox(
                                      width: dimensions.width120*2,
                                      child:  Text(
                                        text[index],
                                        style: const TextStyle(
                                          color: Color(0xFF121212),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    //stars for review
                                    Row(
                                      children: List.generate(
                                        5 ,
                                            (index) => const Icon(
                                          Icons.star,
                                          size: 16,
                                          color: Color(0xFF058FFF),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: dimensions.height32,),
                                    RichText(
                                      text:  TextSpan(
                                        text: prices[index].originalPrice.toString(),
                                        style: const TextStyle(
                                          color: Color(0xFFB7B7B7),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' ${prices[index].discountedPrice}',
                                            style: const TextStyle(
                                              color: Color(0xFF121212),
                                              fontWeight: FontWeight.w700,
                                              decoration: TextDecoration.none,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: dimensions.height36/4,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      if (cart_val>0){
                                        cart_val--;
                                      }
                                    });
                                  },
                                  child: ReusableColoredBox(
                                      width: dimensions.width146,
                                      height: dimensions.height36,
                                      backgroundColor: Colors.transparent,
                                      borderColor: Color(0xFFD6D6D6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ReusableText(text: 'Remove', fontSize: 14, height: 0,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w600,),
                                          Icon(Icons.delete_outline,color: Color(0xFF7A7A7A) ,)
                                        ],
                                      )
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    print('Buy now button pressed');
                                  },
                                  child: ReusableColoredBox(
                                      width: dimensions.width146,
                                      height: dimensions.height36,
                                      backgroundColor: Colors.transparent,
                                      borderColor: Color(0xFFD6D6D6),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ReusableText(text: 'Buy Now', fontSize: 14, height: 0,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w600,),
                                          Icon(Icons.arrow_forward,color: Color(0xFF7A7A7A),size: 20,)
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: dimensions.height8,),
                            // const Divider(
                            //   height: 1.0,
                            //   color: Color(0xFFD6D6D6),
                            // ),
                          ],

                        ),
                      ),
                    ),
              ),

            ),

            SizedBox(height: dimensions.height8*1.5,),

            //apply coupon container
            Container(
              width: dimensions.screenWidth,
              height: dimensions.height8 * 11.5,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensions.width24, vertical: dimensions.height8 * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: 'Apply Coupon',
                      fontSize: 16,
                      color: Color(0xFF282828),
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: dimensions.height8*2), // Add some spacing
                    Row(
                      children: [
                        Container(
                            width:dimensions.width24*11,
                            height: dimensions.height36,
                            child: ReusableTextField('Coupon Code', Icons.local_offer, false, couponController)
                        ),
                        SizedBox(width: dimensions.width16/2), // Add some spacing between TextField and the button if needed
                        InkWell(
                          onTap: (){
                            //apply coupon logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid coupon. Please try again.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Container(
                            width: dimensions.width16*3.4,
                            height: dimensions.height36,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 0.50, color: Color(0xFF00579E)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Center(child: ReusableText(text: 'Apply', fontSize: 14,color: Color(0xFF00579E),fontWeight: FontWeight.w400,fontFamily: FontFamily.roboto,)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: dimensions.height8*1.5,),

            Container(
              width: dimensions.screenWidth,
              height: dimensions.height29*6.3,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height8*2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(text: 'Price Detailes', fontSize: 16,color: Color(0xFF282828),fontWeight: FontWeight.w700,fontFamily: FontFamily.roboto,),
                    SizedBox(height: dimensions.height8*3,),
                    Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(text: 'Price (2 items)', fontSize: 12,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w500,fontFamily: FontFamily.roboto,),
                        ReusableText(text: '₹2,080', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500,fontFamily: FontFamily.roboto,)
                      ],
                    ),
                    SizedBox(height: dimensions.height8*2.5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(text: 'Discount', fontSize: 12,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w500,fontFamily: FontFamily.roboto,),
                        ReusableText(text: '-₹400', fontSize: 12,color: Color(0xFF038B10),fontWeight: FontWeight.w500,fontFamily: FontFamily.roboto,)
                      ],
                    ),
                    SizedBox(height: dimensions.height8*2.5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(text: 'Delivery Charges', fontSize: 12,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w500,fontFamily: FontFamily.roboto,),
                        ReusableText(text: '₹40', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500,fontFamily: FontFamily.roboto,)
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
                        ReusableText(text: 'Total Amount', fontSize: 14,color: Color(0xFF282828),fontWeight: FontWeight.w700,fontFamily: FontFamily.roboto,),
                        ReusableText(text: '₹1720', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500,fontFamily: FontFamily.roboto,)
                      ],
                    ),
                    SizedBox(height: dimensions.height8*1.5,),
                    Container(
                      width: dimensions.width24*14,
                      height: 1,
                      color: Color(0xFFD6D6D6),
                    ),
                    SizedBox(height: dimensions.height8*1.5,),
                    ReusableText(text: 'You will save ₹400 on this order', fontSize: 12,color: Color(0xFF038B10),fontWeight: FontWeight.w600,fontFamily: FontFamily.roboto,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: dimensions.height8 * 9,
        width: dimensions.screenWidth,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensions.width24, vertical: dimensions.height16 * 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price column
              const Column(
                children: [
                  Text(
                    '2160',
                    style: TextStyle(
                      color: Color(0xFFB7B7B7),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    '1680',
                    style: TextStyle(
                      color: Color(0xFF121212),
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: (){
                  print('buy button is tapped');
                },
                child: Container(
                  height: dimensions.height8 * 6,
                  width: dimensions.width146,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xFF058FFF),
                  ),
                  child: Center(
                    child: ReusableText(
                      text: 'Buy Now',
                      fontSize: 16,
                      height: 0.11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
