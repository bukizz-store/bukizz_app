import 'package:bukizz/constants/strings.dart';
import 'package:bukizz/data/repository/banners/banners.dart';
import 'package:bukizz/data/repository/product/general_product.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../Notifications/notifications.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../data/providers/cart_provider.dart';
import '../../../../../../data/providers/school_repository.dart';
import '../../../../../../data/repository/cart_view_repository.dart';
import '../../../../../../data/repository/category/category_repository.dart';
import '../../../../../../widgets/containers/Reusable_ColouredBox.dart';
import '../../../../../../widgets/review widget/review.dart';
import '../../../../../../widgets/text and textforms/Reusable_text.dart';
import '../../../../../../widgets/text and textforms/expandable_text_widget.dart';
import '../../checkout/checkout1.dart';
import 'general_product_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class GeneralProductDescriptionScreen extends StatefulWidget {
  static const route = '/bag description';
  const GeneralProductDescriptionScreen({super.key});

  @override
  State<GeneralProductDescriptionScreen> createState() =>
      _GeneralProductDescriptionScreenState();
}

class _GeneralProductDescriptionScreenState
    extends State<GeneralProductDescriptionScreen> {
  TextEditingController pinController = TextEditingController();
  int _currPageValue = 0;
  @override
  void initState() {
    // TODO: implement initState
    pinController.text =
        AppConstants.isLogin ? AppConstants.userData.address.pinCode : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var categoryRepo = Provider.of<CategoryRepository>(context, listen: false);
    Dimensions dimensions = Dimensions(context);

    return Consumer<GeneralProductRepository>(
      builder: (context, value, child) {
        bool stockOut=value.selectedProduct.set[value.selectedVariationIndex].sku<=0?true:false;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 28.sp,
                ),
                //image for pageview container
                Stack(
                  children: [
                    Container(
                      width: dimensions.screenWidth,
                      height: dimensions.height16 * 20.75,
                      child: PageView.builder(
                        onPageChanged: (int page) {
                          setState(() {
                            _currPageValue = page;
                          });
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: value.selectedProduct
                            .set[value.selectedVariationIndex].image.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(30),
                            ),
                            // child: Image.asset('assets/school/perticular bookset/book.png',fit: BoxFit.contain,),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(30),
                              child: CachedNetworkImage(
                                imageUrl: value
                                    .selectedProduct
                                    .set[value.selectedVariationIndex]
                                    .image[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: 6.w,
                      top: 10.sp,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 25,
                          )),
                    ),
                    if (value.selectedProduct.set[value.selectedVariationIndex]
                            .image.length >
                        1)
                      Positioned(
                        bottom: 5.sp,
                        left: 38.w,
                        child: DotsIndicator(
                          dotsCount: value.selectedProduct
                              .set[value.selectedVariationIndex].image.length,
                          position: _currPageValue.toInt(),
                          decorator: DotsDecorator(
                            activeColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5.0), // Adjust radius to make it circular
                            ),
                            size: const Size.square(4.50),
                            activeSize: const Size.square(
                                9.0), // Make active dot circular
                          ),
                        ),
                      )
                  ],
                ),
                // Container(
                //   width: dimensions.screenWidth,
                //   height: dimensions.height16 * 13.75,
                //   child: PageView.builder(
                //     itemCount: value.selectedProduct.set[value.selectedVariationIndex].image.length,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Container(
                //         child: Image(
                //             image: CachedNetworkImageProvider(value.selectedProduct.set[value.selectedVariationIndex].image[index]
                //         )
                //       ),
                //       );
                //     },
                //   ),
                // ),

                //book description container
                Container(
                  // height: 60.sp,
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
                            value.selectedProduct.name,
                            style: const TextStyle(
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
                            (value
                                                .selectedProduct
                                                .set[value
                                                    .selectedVariationIndex]
                                                .price -
                                            value
                                                .selectedProduct
                                                .set[value
                                                    .selectedVariationIndex]
                                                .salePrice) *
                                        100 /
                                        value
                                            .selectedProduct
                                            .set[value.selectedVariationIndex]
                                            .price >
                                    0
                                ? ReusableText(
                                    text:
                                        '${((value.selectedProduct.set[value.selectedVariationIndex].price - value.selectedProduct.set[value.selectedVariationIndex].salePrice) * 100 / value.selectedProduct.set[value.selectedVariationIndex].price).round()}% Off',
                                    fontSize: 16,
                                    color: Color(0xFF058FFF),
                                    fontWeight: FontWeight.w700,
                                    height: 0.11,
                                  )
                                : Container(),
                            SizedBox(
                              width: dimensions.width24 / 4,
                            ),
                            //listing price
                            Text(
                              'Rs ${value.selectedProduct.set[value.selectedVariationIndex].price}',
                              style: const TextStyle(
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
                              'Rs ${value.selectedProduct.set[value.selectedVariationIndex].salePrice}',
                              style: const TextStyle(
                                color: Color(0xFF121212),
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: dimensions.height8,
                        ),
                        SizedBox(
                          width: dimensions.screenWidth,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Colour: ',
                                  style: TextStyle(
                                    color: Color(0xFF121212),
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: value.selectedProduct
                                      .set[value.selectedVariationIndex].name,
                                  style: const TextStyle(
                                    color: Color(0xFF121212),
                                    fontSize: 16,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: dimensions.height10,
                        ),
                        Container(
                          height: 13.h,
                          width: dimensions.screenWidth,
                          child: ListView.builder(
                              itemCount: value.selectedProduct.variation.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: dimensions.width16),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          value.selectedVariationIndex = index;
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: index ==
                                                          value
                                                              .selectedVariationIndex
                                                      ? Colors.blue
                                                      : Colors.black38,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 30,
                                              child: ClipOval(
                                                  child: CachedNetworkImage(
                                                imageUrl: value
                                                    .selectedProduct
                                                    .variation[
                                                        index.toString()]!['0']!
                                                    .image[0],
                                                fit: BoxFit.cover,
                                              ))),
                                        ),
                                      ),
                                      SizedBox(
                                        height: dimensions.height10,
                                      ),
                                      ReusableText(
                                        text: value
                                            .selectedProduct.set[index].name,
                                        fontSize: 16,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),

                        if(stockOut)
                          SizedBox(
                            width: 345,
                            child: Text(
                              'Out of Stock',
                              style: TextStyle(
                                color: Color(0xFFFC2A2A),
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: dimensions.height24 / 3,
                ),

                //pincode  check
                // Container(
                //   width: 100.w,
                //   color: Colors.white,
                //   padding: EdgeInsets.only(
                //       left: dimensions.width24,
                //       top: dimensions.height16,
                //       bottom: dimensions.height16,
                //       right: dimensions.width24),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       ReusableText(
                //         text: 'Delivery & Services',
                //         fontSize: 18,
                //         fontWeight: FontWeight.w700,
                //         color: Color(0xFF121212),
                //       ),
                //       SizedBox(
                //         height: dimensions.height8 * 3,
                //       ),
                //       ReusableText(
                //         text: 'Enter Delivery Pincode',
                //         fontSize: 10,
                //         fontWeight: FontWeight.w500,
                //         color: Color(0xFF444444),
                //       ),
                //       SizedBox(
                //         height: dimensions.height8,
                //       ),
                //       Container(
                //         alignment: Alignment.center,
                //         width: dimensions.screenWidth,
                //         height: 27.sp,
                //         child: TextField(
                //           maxLength: 6,
                //           keyboardType: TextInputType.number,
                //           controller: pinController,
                //           decoration: InputDecoration(
                //             contentPadding: EdgeInsets.symmetric(
                //                 horizontal: dimensions.height8 * 2),
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(6),
                //               borderSide: const BorderSide(
                //                   width: 0.50, color: Color(0xFFB7B7B7)),
                //             ),
                //             focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(6),
                //               borderSide: const BorderSide(
                //                   width: 0.50, color: Color(0xFFB7B7B7)),
                //             ),
                //             suffixIcon: GestureDetector(
                //               onTap: () {
                //                 checkDeliverable();
                //               },
                //               child: const Padding(
                //                 padding: EdgeInsets.symmetric(vertical: 10.0),
                //                 child: Text(
                //                   'Check',
                //                   style: TextStyle(
                //                     color: Color(0xFF058FFF),
                //                     fontSize: 14,
                //                     fontFamily: 'Nunito',
                //                     fontWeight: FontWeight.w500,
                //                     height: 0,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             counterText: '',
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: dimensions.height8,
                //       ),
                //       isDeliverable
                //           ? Row(
                //               children: [
                //                 Icon(
                //                   Icons.local_shipping,
                //                   color: Color(0xFF39A7FF),
                //                 ),
                //                 SizedBox(
                //                   width: dimensions.width10 / 2,
                //                 ),
                //                 //code for displaying the delivery date two day after the today date and time
                //                 ReusableText(
                //                   text: 'Estimated delivery by 21st March',
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w500,
                //                   color: Color(0xFF444444),
                //                 )
                //               ],
                //             )
                //           : Row(
                //               children: [
                //                 Icon(
                //                   Icons.warning_rounded,
                //                   color: AppColors.red,
                //                 ),
                //                 SizedBox(
                //                   width: dimensions.width10 / 2,
                //                 ),
                //                 //code for displaying the delivery date two day after the today date and time
                //                 ReusableText(
                //                   text: 'Delivery Unavailable at this Pin code',
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w500,
                //                   color: AppColors.red,
                //                 )
                //               ],
                //             )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: dimensions.height10,
                // ),
                ExpandableTextWidget(
                  title: "Description",
                  text: value.selectedProduct.description,
                ),
                SizedBox(
                  height: dimensions.height24 / 3,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensions.width16,
                      vertical: dimensions.height16),
                  child: ReusableText(text: 'Explore More', fontSize: 18),
                ),
                Container(
                  height: 56.sp,
                  width: dimensions.screenWidth,
                  // color: Colors.red,
                  padding: EdgeInsets.only(left: dimensions.width16),
                  child: ListView.builder(
                      itemCount: value.generalProduct.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            value.selectedProduct = value.generalProduct[index];
                            Navigator.pushNamed(
                                context, GeneralProductDescriptionScreen.route);
                          },
                          child: Container(
                            width: dimensions.width146,
                            height: 45.sp,
                            margin: EdgeInsets.only(
                                right: dimensions.width16,
                                bottom: dimensions.height10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x2600579E),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: dimensions.width169,
                                  height: dimensions.height105 * 0.95,
                                  child: Image(
                                    image: CachedNetworkImageProvider(value
                                        .generalProduct[index].set[0].image[0]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: dimensions.height24 / 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: dimensions.height16,
                                      ),
                                      ReusableText(
                                        text:
                                            '${value.generalProduct[index].board}',
                                        fontSize: 14,
                                        height: 0.11,
                                        color: Color(0xFF058FFF),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      SizedBox(
                                        height: dimensions.height16,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text:
                                              '${value.generalProduct[index].set[0].price} ',
                                          style: const TextStyle(
                                            color: Color(0xFFB7B7B7),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: 'nunito',
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  ' ₹ ${value.generalProduct[index].set[0].salePrice}',
                                              style: const TextStyle(
                                                color: Color(0xFF121212),
                                                fontWeight: FontWeight.w700,
                                                decoration: TextDecoration.none,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: dimensions.height24 / 3),
                                      // SizedBox(height: dimensions.height24 / 3),
                                      // Row(
                                      //   children: List.generate(
                                      //     5,
                                      //         (index) => Icon(
                                      //       Icons.star,
                                      //       size: 16,
                                      //       color: Color(0xFF058FFF),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                // accesories
                SizedBox(
                  height: dimensions.height16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensions.width16,
                      vertical: dimensions.height8),
                  child: ReusableText(
                      text: 'Frequently Bought Together', fontSize: 18),
                ),
                SizedBox(
                  height: dimensions.height16,
                ),
                categoryRepo.category.isNotEmpty
                    ? Container(
                        height: dimensions.height10 * 17,
                        width: dimensions.screenWidth,
                        // color: Colors.red,
                        padding: EdgeInsets.only(left: dimensions.width16),
                        child: ListView.builder(
                            itemCount: categoryRepo.category.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              // print(categoryRepo.category.length);
                              var selectedModel = categoryRepo.category[index];
                              return (selectedModel.categoryId !=
                                      value.selectedProduct.categoryId)
                                  ? GestureDetector(
                                      onTap: () {
                                        context
                                            .read<CategoryRepository>()
                                            .selectedCategory = selectedModel;
                                        context
                                            .read<GeneralProductRepository>()
                                            .getGeneralProductFromFirebase(
                                                selectedModel.categoryId);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GeneralProductScreen(
                                                        product: selectedModel
                                                            .name)));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: dimensions.width16,
                                            bottom: dimensions.height10),
                                        width: dimensions.width146,
                                        height: dimensions.height10,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                              width: 0.50,
                                              strokeAlign:
                                                  BorderSide.strokeAlignOutside,
                                              color: Color(0xFFD6D6D6),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          shadows: const [
                                            BoxShadow(
                                              color: Color(0x2600579E),
                                              blurRadius: 12,
                                              offset: Offset(0, 4),
                                              spreadRadius: 0,
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: dimensions.width146,
                                              height: dimensions.height10 * 9,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12),
                                                          topRight:
                                                              Radius.circular(
                                                                  12)),
                                                  child: CachedNetworkImage(
                                                    fit: BoxFit.fitHeight,
                                                    imageUrl:
                                                        selectedModel.image,
                                                  )),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      dimensions.width24 / 3,
                                                  vertical:
                                                      dimensions.height10 * 2),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ReusableText(
                                                    text: selectedModel.name,
                                                    fontSize: 14,
                                                    color: Color(0xFF444444),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        dimensions.height10 * 2,
                                                  ),
                                                  ReusableText(
                                                    text: selectedModel.offers,
                                                    fontSize: 14,
                                                    color: Color(0xFF121212),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container();
                            }),
                      )
                    : Center(
                        child: SpinKitChasingDots(
                        color: AppColors.primaryColor,
                        size: 24,
                      )),

                SizedBox(
                  height: dimensions.height24 / 3,
                ),

                ReviewListWidget(),
              ],
            ),
          ),
          //todo  add it after publishing
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
                    onTap: AppConstants.isLogin
                        ? () async {
                            if(!stockOut){
                              var schoolData = context.read<SchoolDataProvider>();
                              await context
                                  .read<CartProvider>()
                                  .addProductInCart(
                                  'all',
                                  value.selectedProduct
                                      .set[value.selectedVariationIndex].name,
                                  'null',
                                  1,
                                  value.selectedProduct.productId,
                                  context,
                                  AppString.generalType)
                                  .then((value) => AppConstants.showCartSnackBar(
                                context,
                              ));
                            }
                          }
                        : () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, SignIn.route, (route) => false);
                          },
                    child: Container(
                      height: dimensions.height8 * 6,
                      width: dimensions.width146,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50, color: stockOut?Colors.grey:Color(0xFF00579E)),
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
                            color: stockOut?Colors.grey:Color(0xFF00579E),
                          ),
                          Icon(
                            Icons.shopping_cart,
                            color:stockOut?Colors.grey:Color(0xFF00579E),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: !stockOut?
                        () async {
                      var cartView = context.read<CartViewRepository>();
                      cartView.isSingleBuyNow = true;
                      cartView.setTotalPrice(value
                          .selectedProduct
                          .variation[value.selectedVariationIndex.toString()]![
                              '0']!
                          .price);
                      cartView.setSalePrice(value
                          .selectedProduct
                          .variation[value.selectedVariationIndex.toString()]![
                              '0']!
                          .salePrice);
                      await context.read<CartViewRepository>().getCartProduct(
                          value.selectedProduct.productId,
                          'all',
                          value.selectedProduct
                              .set[value.selectedVariationIndex].name,
                          'null',
                          1,
                          AppString.generalType);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Checkout1()),
                      );
                    }:
                        (){},
                    child: Container(
                      height: dimensions.height8 * 6,
                      width: dimensions.width146,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: stockOut?Colors.grey:Color(0xFF058FFF),
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
      },
    );
  }

  bool isDeliverable = false;

  Future<void> checkDeliverable() async {
    await FirebaseDatabase.instance
        .ref()
        .child('pincode')
        .child(context.read<SchoolDataProvider>().selectedSchool.city)
        .get()
        .then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        if (snapshot.value.toString().contains(pinController.text)) {
          setState(() {
            isDeliverable = true;
          });
          print('pincode found');
        } else {
          setState(() {
            isDeliverable = false;
          });
          print('pincode not found');
        }
      } else {
        setState(() {
          isDeliverable = false;
        });
        print('Location not Exist');
      }
    });
  }

  void checkDeliveryDate() {
    DateTime now = DateTime.now();

    // Calculate delivery date
    DateTime deliveryDate = now.add(Duration(days: 2));

    // Format the delivery date
    String formattedDeliveryDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(deliveryDate);

    // Display the delivery date
    print('Delivery Date: $formattedDeliveryDate');
  }
}
