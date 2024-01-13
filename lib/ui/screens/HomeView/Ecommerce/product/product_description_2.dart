import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import'package:flutter/material.dart';

import '../../../../../constants/font_family.dart';
import '../../../../../utils/dimensions.dart';



class ProductDescriptionScreen2 extends StatelessWidget {
  static const String route = '/product_description_screen2';
  const ProductDescriptionScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //image
          Positioned(
              left: 0,
              right: 0,
              child:
              Container(
                width: double.maxFinite,
                height: dimensions.screenHeight/2.41,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(

                          'assets/school/booksets/class1 bookset.png',
                        )
                    )
                ),
              )
          ),

          //icons on image
          Positioned(
              top:dimensions.height48 ,
              left: dimensions.width24,
              right: dimensions.width24,
              child: const Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                children: [
                  Icon( Icons.arrow_back_ios),
                  Icon(Icons.shopping_cart_outlined),
                ],
              )),

          //introduction of the food
          Positioned(
              left: 0, right: 0, top: dimensions.screenHeight/2.41-20,bottom: 0,
              child:
              Container(
                  padding: EdgeInsets.only(left:20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      color: Colors.white
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // AppColumn(text: 'Dum Biryani',),
                      SizedBox(height: 20,),

                      ReusableText(text: 'Introduce', fontSize: 16, height: 0.10,),

                      SizedBox(height: 20,),


                      ReusableText(text: 'Bookset details can be filled here', fontSize: 16, height: 0.10,fontWeight: FontWeight.w400,)

                    ],
                  )
              ))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Container(
            width: dimensions.screenWidth,
            height: 500,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //add to cart
                  GestureDetector(
                    onTap: (){
                      print('add to cart button clicked');
                    },
                    child: Container(
                      height: 64,
                      width: 150,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.shopping_cart),
                          ReusableText(text: 'Add to Cart', fontSize: 16, height: 0.10),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      print('place order button tapped');
                    },
                    child: Container(
                      height: 64,
                      width: 200,
                      decoration: ShapeDecoration(
                        color: Color(0xFF03045E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: dimensions.height16,
                            horizontal: dimensions.width16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                ReusableText(
                                  text: '₹1349',
                                  fontSize: 14,
                                  height: 0.11,
                                  fontFamily: FontFamily.roboto,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFF6FDFE),
                                ),
                                // SizedBox(height: 4,),
                                // ReusableText(text: 'TOTAL', fontSize: 12, height: 0.12,fontFamily: FontFamily.roboto,fontWeight:FontWeight.w500,color: Color(0xFFF6FDFE),)
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    ReusableText(
                                      text: 'Place Order',
                                      fontSize: 16,
                                      height: 0.09,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFF6FDFE),
                                    ),
                                    // Icon(Icons.arrow_right),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
