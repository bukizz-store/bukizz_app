import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/data/repository/product/general_product.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/Stationary/general_product_description_screen.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../widgets/text and textforms/Reusable_text.dart';


class GeneralProductScreen extends StatefulWidget {
  static const route = '/stationary view';
  final String product;
  const GeneralProductScreen({super.key, required this.product});

  @override
  State<GeneralProductScreen> createState() => _GeneralProductScreenState();
}

class _GeneralProductScreenState extends State<GeneralProductScreen> {
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    return Consumer<GeneralProductRepository>(builder: (context , value, child){
      if(value.isProductLoaded == false){
        return const Scaffold(body: Center(child: SpinKitChasingDots(color: AppColors.primaryColor, size: 24,)));
      }
      return Scaffold(
        appBar: AppBar(
          title: ReusableText(
            text: "All ${widget.product}",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          // centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dimensions.width24 / 2,
                vertical: dimensions.height24),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: dimensions.width24 / 1.5,
                    mainAxisSpacing: dimensions.height8 * 2,
                    mainAxisExtent:57.sp),
                itemCount: value.generalProduct.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      value.selectedProduct = value.generalProduct[index];
                      Navigator.pushNamed(context, GeneralProductDescriptionScreen.route);
                    },
                    child: Container(
                      // height: dimensions.height105,
                      width: dimensions.width169,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
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
                              image: CachedNetworkImageProvider(
                                  value.generalProduct[index].set[0].image[0]),
                                  fit: BoxFit.cover,

                              ),
                            ),
                          SizedBox(height: dimensions.height24 / 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: dimensions.height16,),
                                ReusableText(
                                  text: '${value.generalProduct[index].board}',
                                  fontSize: 14,
                                  height: 0.11,
                                  color: Color(0xFF058FFF),
                                  fontWeight: FontWeight.w700,
                                ),
                                SizedBox(height: dimensions.height16,),
                                RichText(
                                  text: TextSpan(
                                    text: '${value.generalProduct[index].set[0].price} ',
                                    style: const TextStyle(
                                      color: Color(0xFFB7B7B7),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      fontFamily: 'nunito',
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' ₹ ${value.generalProduct[index].set[0].salePrice}',
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
                                // SizedBox(height: dimensions.height24 / 3),
                                (value.generalProduct[index].set[0].price - value.generalProduct[index].set[0].salePrice) *
                                    100 /
                                    value.generalProduct[index].set[0].price > 1
                                    ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: dimensions.height24 / 3),
                                    ReusableText(
                                      text:
                                      '${((value.generalProduct[index].set[0].price - value.generalProduct[index].set[0].salePrice) * 100 / value.generalProduct[index].set[0].price).floor()} % off',
                                      fontSize: 12,
                                      height: 0.11,
                                      color: Color(0xFF058FFF),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ],
                                )
                                    : SizedBox(),
                                SizedBox(height: dimensions.height24 / 3),
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
                })),
      );
    });
  }
}
