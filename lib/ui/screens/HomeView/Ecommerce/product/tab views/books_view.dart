import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/product/product_description_screen.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/product/tab_screen.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/containers/class_number.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../data/providers/product_provider.dart';
import '../../../../../../data/providers/school_repository.dart';
import '../../../../../../data/repository/product_view_repository.dart';


class Books extends StatefulWidget {
  const Books({super.key,});

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  @override

  Widget build(BuildContext context) {
    var productView = context.watch<ProductViewRepository>();
    // var productData = context.read<ProductProvider>();
    var schoolData = context.read<SchoolDataProvider>();
    Dimensions dimensions = Dimensions(context);
    return productView.getIsProductAdded ?  Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dimensions.width24/2,vertical: dimensions.height24/2),
        child: GridView.builder(
            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // Set the number of columns in the grid
              crossAxisSpacing: dimensions.width24/1.5,
              // Set the horizontal spacing between column
              mainAxisSpacing: dimensions.height8*2, // Set the vertical spacing between rows

              mainAxisExtent: dimensions.height10*17
            ),
            itemCount: schoolData.selectedSchool.productsId.length,
            itemBuilder: (context, index) {
              var product = productView.productData[index];
              print(product.classId.substring(3,product.classId.length));
              return GestureDetector(
                onTap: (){
                  // productData.setProductDetail(product);
                  productView.setProductDetail(productView.productData[index]);
                  productView.setProductName(schoolData.schoolName);
                  productView.setSelectedSetData(0);
                  productView.setSelectedStreamData(0);
                  productView.setTotalSalePrice();
                  productView.setTotalPrice();
                  Navigator.of(context).pushNamed(ProductDescriptionScreen.route);
                },
                child: Container(
                  height: dimensions.height105,
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

                      CustomClassContainer(
                          width: dimensions.width169,
                          height: dimensions.height10*10.5,
                          classNumber: suffix(int.parse(product.classId.substring(3))),
                          classTextLeft: dimensions.width10*5.5, //margin to text->class
                          classTextRight:  dimensions.width10*5.5,
                          classTextTop: dimensions.height10*2.84,
                          classNumberLeft: dimensions.width10*4.3, //margin to class No.
                          classNumberRight: dimensions.width10*4.3,
                          classNumberTop: dimensions.height10*5.3
                      ),
                      SizedBox(height: dimensions.height24 / 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: (product.price != null) ?  product.price.floor().toString() : '',
                                style: const TextStyle(
                                  color: Color(0xFFB7B7B7),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' ₹ ${product.salePrice}',
                                    style: TextStyle(
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
                            ReusableText(
                              text: '20 % off',
                              fontSize: 12,
                              height: 0.11,
                              color: Color(0xFF058FFF),
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: dimensions.height24 / 3),
                            Row(
                              children: List.generate(
                                5,
                                    (index) => Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color(0xFF058FFF),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              );
            }
        )
      ),
    ) : const Center(
      child: CircularProgressIndicator(),
    );
  }
}

