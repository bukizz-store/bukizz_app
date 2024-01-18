import 'package:bukizz_1/data/providers/cart_provider.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/font_family.dart';
import '../../../../../data/providers/productModel_provider.dart';
import '../../../../../utils/dimensions.dart';



import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/font_family.dart';
import '../../../../../widgets/containers/Reusable_ColouredBox.dart';
import '../../../../../widgets/review widget/review.dart';
import '../../../../../widgets/text and textforms/expandable_text_widget.dart';


String bookDescription = "The foundation of your English studies, these official textbooks delve deep into prescribed poems, stories, plays, and grammar concepts, ensuring thorough understanding and exam preparedness. Supplementary Readers: Expand your horizons with captivating novels, captivating short stories, and thought-provoking essays that fuel your imagination and broaden your literary perspective. Practice Papers & Sample Questions: Hone your skills and build confidence with targeted practice exercises and model question papers that mirror the CBSE exam format. Study Guides & Explanations: Get instant access to clear explanations, insightful interpretations, and valuable learning tips that unlock the meaning behind every text and grammar rule. Interactive Activities & Quizzes";
List<String> setText = [
  'Book Roll',
  'Paint Box',
];

//price will go accordingly
List<double> setPrices = [
  80.0,
  100.0,
];

//cart quantities initialised with 0
List<int> setCartQuantities = [
  0,
  0,
];
List<String> setImages = [
  'assets/cart/book roll.png',
  'assets/cart/color box.png',
  // Add more image paths as needed
];

class ProductDescriptionScreen extends StatefulWidget {
  static const String route = '/productdescription';
  const ProductDescriptionScreen({super.key});

  @override
  State<ProductDescriptionScreen> createState() => _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Wisdom World School'),

      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            //image for pageview container
            Container(
              width: dimensions.screenWidth,
              height: dimensions.height16*13.75,

              child: PageView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(

                    child: Image.asset('assets/school/perticular bookset/book.png',fit: BoxFit.contain,),
                  ),
                  Container(
                    child: Image.asset('assets/school/perticular bookset/book.png',fit: BoxFit.contain,),
                  ),
                ],
              ),
            ),

            //book description container
            Container(
              height: dimensions.height8*13,
              color: Colors.white,
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal:dimensions.width24,vertical: dimensions.height8 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 345,
                      child: Text(
                        'English Book Set - Wisdom World School - Class 1st',
                        style: TextStyle(
                          color: Color(0xFF121212),
                          fontSize: 20,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(height: dimensions.height24/2,),
                    Row(
                      children: [
                        //discount text
                        ReusableText(text: '20% Off', fontSize: 16,color: Color(0xFF058FFF),fontWeight: FontWeight.w700, height: 0.11, ),
                        SizedBox(width: dimensions.width24/4,),
                        //listing price
                        const Text(
                          '1200',
                          style: TextStyle(
                            color:  Color(0xFF7A7A7A),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),

                        SizedBox(width: dimensions.width24/4,),
                        //discounted price
                        const Text(
                          '800',
                          style: TextStyle(
                            color:  Color(0xFF121212),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: dimensions.height24/3,),
            //expandable text
            ExpandableTextWidget(text: bookDescription),
            SizedBox(height: dimensions.height24/3,),

            // accesories
            ReusableColoredBox(
              width: dimensions.screenWidth,
              height: dimensions.height8*27,
              backgroundColor: Colors.white,
              borderColor: Color(0xFFE8E8E8),

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //complete your set with -> text

                    ReusableText(
                      text: 'Complete your set',
                      fontSize: 18,
                      height: 0.09,
                      fontFamily: FontFamily.roboto,
                      fontWeight: FontWeight.w700,
                      color:Color(0xFF121212),
                    ),
                    SizedBox(height: dimensions.height16,),
                    Container(
                      height: dimensions.height151,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: dimensions.width16),
                            child: ReusableColoredBox(
                              width: dimensions.width169,
                              height: dimensions.height172,
                              backgroundColor: Colors.white,
                              borderColor: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image container
                                  Container(
                                    width: dimensions.width169,
                                    height: dimensions.height86,
                                    child: Image(image: AssetImage(setImages[index])),
                                  ),

                                  // Book roll text hardcoded
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: dimensions.height8,
                                      left: dimensions.width24 / 2,
                                    ),
                                    child: ReusableText(
                                      text: setText[index],
                                      fontSize: 12,
                                      height: 0.11,
                                      fontFamily: FontFamily.roboto,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF03045E),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: dimensions.height8 * 2,
                                      left: dimensions.width24 / 2,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ReusableText(
                                          text: '₹ ${setPrices[index]}',
                                          fontSize: 12,
                                          height: 0.11,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: FontFamily.roboto,
                                          color: Color(0xFF03045E),
                                        ),

                                        // Plus minus button functional
                                        ReusableColoredBox(
                                          width: dimensions.width80 / 1.25,
                                          height: dimensions.height24,
                                          backgroundColor: Colors.white,
                                          borderColor: Colors.black,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                child: Icon(Icons.remove),
                                                onTap: () {
                                                  setState(() {
                                                    if (setCartQuantities[index] > 0) {
                                                      setCartQuantities[index]--;
                                                    }
                                                  });
                                                },
                                              ),
                                              ReusableText(
                                                text: '${setCartQuantities[index]}',
                                                fontSize: 12,
                                                height: 0.10,
                                              ),
                                              GestureDetector(
                                                child: Icon(Icons.add),
                                                onTap: () {
                                                  setState(() {
                                                    setCartQuantities[index]++;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: dimensions.height24/3,),

            ReviewListWidget(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: dimensions.height8 * 9,
        width: dimensions.screenWidth,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  print('cart button is tapped');
                },
                child: Container(
                  height: dimensions.height8 * 6,
                  width: dimensions.width146,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Color(0xFF00579E)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReusableText(
                        text: 'Add to Cart',
                        fontSize: 16,
                        height: 0.11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF00579E),
                      ),
                      Icon(Icons.shopping_cart,color: Color(0xFF00579E),),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print('buy button is tapped');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Checkout1()),
                  );

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


// class ProductDescriptionScreen extends StatelessWidget {
//   static const String route = '/product_description_screen2';
//   const ProductDescriptionScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var productData = context.read<ProductProvider>();
//     Dimensions dimensions=Dimensions(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           //image
//           Positioned(
//               left: 0,
//               right: 0,
//               child:
//               Container(
//                 width: double.maxFinite,
//                 height: dimensions.screenHeight/2.41,
//                 // decoration: const BoxDecoration(
//                 //     image: DecorationImage(
//                 //         fit: BoxFit.cover,
//                 //         image: AssetImage(
//                 //
//                 //           'assets/school/booksets/class1 bookset.png',
//                 //         )
//                 //     )
//                 // ),
//               )
//           ),
//
//           //icons on image
//           Positioned(
//               top:dimensions.height48 ,
//               left: dimensions.width24,
//               right: dimensions.width24,
//               child: const Row(
//                 mainAxisAlignment:MainAxisAlignment.spaceBetween ,
//                 children: [
//                   Icon( Icons.arrow_back_ios),
//                   Icon(Icons.shopping_cart_outlined),
//                 ],
//               )),
//
//           //introduction of the food
//           Positioned(
//               left: 0, right: 0, top: dimensions.screenHeight/2.41-20,bottom: 0,
//               child:
//               Container(
//                   padding: EdgeInsets.only(left:20,right: 20),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(20),
//                         topLeft: Radius.circular(20),
//                       ),
//                       color: Colors.white
//                   ),
//                   child:Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // AppColumn(text: 'Dum Biryani',),
//                       SizedBox(height: 20,),
//
//                       ReusableText(text: productData.productDetail.name, fontSize: 16, height: 0.10,),
//
//                       SizedBox(height: 20,),
//
//
//                       ReusableText(text: 'Bookset details can be filled here', fontSize: 16, height: 0.10,fontWeight: FontWeight.w400,)
//
//                     ],
//                   )
//               ))
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//           elevation: 0.0,
//           child: Container(
//             width: dimensions.screenWidth,
//             height: 500,
//             color: Colors.white,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   //add to cart
//                   GestureDetector(
//                     onTap: (){
//                       // print('add to cart button clicked');
//                       context.read<CartProvider>().addProductInCart(productData.productDetail.productId, context);
//                     },
//                     child: Container(
//                       height: 64,
//                       width: 150,
//                       decoration: ShapeDecoration(
//                         color: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8)),
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(Icons.shopping_cart),
//                           ReusableText(text: 'Add to Cart', fontSize: 16, height: 0.10),
//                         ],
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: (){
//                       print('place order button tapped');
//                     },
//                     child: Container(
//                       height: 64,
//                       width: 200,
//                       decoration: ShapeDecoration(
//                         color: Color(0xFF03045E),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8)),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                             vertical: dimensions.height16,
//                             horizontal: dimensions.width16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Column(
//                               children: [
//                                 ReusableText(
//                                   text: '₹1349',
//                                   fontSize: 14,
//                                   height: 0.11,
//                                   fontFamily: FontFamily.roboto,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xFFF6FDFE),
//                                 ),
//                                 // SizedBox(height: 4,),
//                                 // ReusableText(text: 'TOTAL', fontSize: 12, height: 0.12,fontFamily: FontFamily.roboto,fontWeight:FontWeight.w500,color: Color(0xFFF6FDFE),)
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     ReusableText(
//                                       text: 'Place Order',
//                                       fontSize: 16,
//                                       height: 0.09,
//                                       fontWeight: FontWeight.w700,
//                                       color: Color(0xFFF6FDFE),
//                                     ),
//                                     // Icon(Icons.arrow_right),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }