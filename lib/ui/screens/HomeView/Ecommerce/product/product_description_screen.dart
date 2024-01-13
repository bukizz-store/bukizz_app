import 'dart:math';

import 'package:bukizz_1/constants/colors.dart';
import 'package:bukizz_1/data/models/ecommerce/cart_model.dart';
import 'package:bukizz_1/data/repository/user_repository.dart';
import 'package:bukizz_1/widgets/containers/Reusable_ColouredBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/font_family.dart';
import '../../../../../data/providers/cart_provider.dart';
import '../../../../../data/providers/productModel_provider.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';

class ProductDescriptionScreen extends StatefulWidget {
  static const String route = '/product_description_screen';
  const ProductDescriptionScreen({super.key});

  @override
  State<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    var productData = context.read<ProductProvider>();
    var userDetail = Provider.of<UserRepositoryProvider>(context, listen: false);
    Dimensions dimensions = Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('product description'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              dimensions.width24,
              dimensions.height16,
              dimensions.width24,
              0,
            ),
            child: Column(
              children: [
                ReusableColoredBox(
                    width: double.infinity,
                    height: 350,
                    backgroundColor: Colors.white,
                    borderColor: Colors.transparent,

                    //here we can use listview for difrent images
                    child: Image(
                      image: AssetImage(
                          'assets/school/booksets/class1 bookset.png'),
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: dimensions.height16,
                ),
                Row(
                  children: [
                    ReusableText(
                        text: productData.productDetail.name,
                        fontSize: 16,
                        height: 0.09,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.roboto),
                  ],
                ),
              ],
            ),
          ),
        ),
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
                    onTap: () {
                      var cartProvider = context.read<CartProvider>();
                      cartProvider.addProductInCart(productData.productDetail.productId , context);
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
                          ReusableText(
                              text: 'Add to Cart', fontSize: 16, height: 0.10),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
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
                                  text:
                                      '₹ ${productData.productDetail.price.toString()}',
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
