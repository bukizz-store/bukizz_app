import 'package:bukizz_1/data/providers/cart_provider.dart';
import 'package:bukizz_1/data/providers/school_repository.dart';
import 'package:bukizz_1/data/repository/cart_view_repository.dart';
import 'package:bukizz_1/data/repository/product_view_repository.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/Cart/cart_screen.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/font_family.dart';
import '../../../../../data/providers/product_provider.dart';
import '../../../../../data/providers/stationary_provider.dart';
import '../../../../../utils/dimensions.dart';

import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/font_family.dart';
import '../../../../../widgets/containers/Reusable_ColouredBox.dart';
import '../../../../../widgets/review widget/review.dart';
import '../../../../../widgets/text and textforms/expandable_text_widget.dart';
import '../checkout/checkout1.dart';

String bookDescription =
    "The foundation of your English studies, these official textbooks delve deep into prescribed poems, stories, plays, and grammar concepts, ensuring thorough understanding and exam preparedness. Supplementary Readers: Expand your horizons with captivating novels, captivating short stories, and thought-provoking essays that fuel your imagination and broaden your literary perspective. Practice Papers & Sample Questions: Hone your skills and build confidence with targeted practice exercises and model question papers that mirror the CBSE exam format. Study Guides & Explanations: Get instant access to clear explanations, insightful interpretations, and valuable learning tips that unlock the meaning behind every text and grammar rule. Interactive Activities & Quizzes";
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
  State<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    var productView = context.read<ProductViewRepository>();
    var schoolData = context.read<SchoolDataProvider>();
    var stationaryData = context.read<StationaryProvider>();
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(schoolData.selectedSchool.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //image for pageview container
            Container(
              width: dimensions.screenWidth,
              height: dimensions.height16 * 13.75,
              child: PageView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    // child: Image.asset('assets/school/perticular bookset/book.png',fit: BoxFit.contain,),
                    child: Image.network(productView.selectedProduct.image),
                  ),
                  // Container(
                  //   child: Image.asset('assets/school/perticular bookset/book.png',fit: BoxFit.contain,),
                  // ),
                ],
              ),
            ),

            //book description container
            Container(
              height: dimensions.height8 * 13,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: dimensions.width24,
                    vertical: dimensions.height8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 345,
                      child: Text(
                        productView.selectedProduct.name == ''
                            ? 'English Book Set - Wisdom World School - Class 1st'
                            : productView.selectedProduct.name,
                        style: TextStyle(
                          color: Color(0xFF121212),
                          fontSize: 20,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: dimensions.height24 / 2,
                    ),
                    Row(
                      children: [
                        //discount text
                        ReusableText(
                          text: '20% Off',
                          fontSize: 16,
                          color: Color(0xFF058FFF),
                          fontWeight: FontWeight.w700,
                          height: 0.11,
                        ),
                        SizedBox(
                          width: dimensions.width24 / 4,
                        ),
                        //listing price
                        Text(
                          productView.selectedProduct.price.floor().toString(),
                          style: TextStyle(
                            color: Color(0xFF7A7A7A),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),

                        SizedBox(
                          width: dimensions.width24 / 4,
                        ),
                        //discounted price
                        Text(
                          productView.selectedProduct.salePrice == ''
                              ? 800.toString()
                              : productView.selectedProduct.salePrice.toString(),
                          style: TextStyle(
                            color: Color(0xFF121212),
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

            SizedBox(
              height: dimensions.height24 / 3,
            ),
            //expandable text
            ExpandableTextWidget(text: productView.selectedProduct.description),
            SizedBox(
              height: dimensions.height24 / 3,
            ),

            // accesories
            ReusableColoredBox(
              width: dimensions.screenWidth,
              height: dimensions.height8 * 27,
              backgroundColor: Colors.white,
              borderColor: Color(0xFFE8E8E8),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: dimensions.width24,
                    vertical: dimensions.height16),
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
                      color: Color(0xFF121212),
                    ),
                    SizedBox(
                      height: dimensions.height16,
                    ),
                    Container(
                      height: dimensions.height151,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: stationaryData.stationaryListItems.length,
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
                                    child: Image(
                                        image: NetworkImage(stationaryData.stationaryListItems[index].image)),
                                  ),

                                  // Book roll text hardcoded
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: dimensions.height8,
                                      left: dimensions.width24 / 2,
                                    ),
                                    child: ReusableText(
                                      text: stationaryData.stationaryListItems[index].name,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ReusableText(
                                          text: '₹ ${stationaryData.stationaryListItems[index].price}',
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                child: Icon(Icons.remove),
                                                onTap: () {
                                                  // setState(() {
                                                  //   if (setCartQuantities[
                                                  //           index] >
                                                  //       0) {
                                                  //     setCartQuantities[
                                                  //         index]--;
                                                  //   }
                                                  // });
                                                  context.read<CartProvider>().removeSingleCartData("all" ,stationaryData.stationaryListItems[index].productId, context , 1);
                                                },
                                              ),
                                              ReusableText(
                                                text:
                                                    '${1}',
                                                fontSize: 12,
                                                height: 0.10,
                                              ),
                                              GestureDetector(
                                                child: Icon(Icons.add),
                                                onTap: () {
                                                  // setState(() {
                                                  //   setCartQuantities[index]++;
                                                  // });
                                                  context.read<CartProvider>().addProductInCart("all", 1, stationaryData.stationaryListItems[index].productId, context);

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

            SizedBox(
              height: dimensions.height24 / 3,
            ),

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
                  // context.read<CartProvider>().addProductInCart(
                  //     productView.selectedProduct.productId, context);
                  context.read<CartProvider>().addProductInCart(schoolData.selectedSchool.name, 1, productView.selectedProduct.productId, context);
                  // context.read<CartViewRepository>().setCartData(
                  //     schoolData.schoolName,
                  //     context
                  //         .read<CartProvider>()
                  //         .getCartData
                  //         .productsId[productView.selectedProduct.productId]!,
                  //     productView.selectedProduct.productId);
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
                      Icon(
                        Icons.shopping_cart,
                        color: Color(0xFF00579E),
                      ),
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
