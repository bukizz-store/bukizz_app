import 'package:bukizz_1/constants/colors.dart';
import 'package:bukizz_1/data/repository/product_view_repository.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/product/product_description_screen.dart';
import 'package:bukizz_1/widgets/containers/Reusable_ColouredBox.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/providers/productModel_provider.dart';
import '../../../../../data/providers/school_repository.dart';

class ProductScreen extends StatefulWidget {
  static const route = '/product_screen';
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var schoolData = context.read<SchoolDataProvider>();
    var productData = context.read<ProductProvider>();
    var productView = context.watch<ProductViewRepository>();
    List<String> schoolImages = [
      'assets/school/booksets/class1 bookset.png',
      'assets/school/booksets/class2 bookset.png',
      'assets/school/booksets/class3 bookset.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(schoolData.schoolName),
      ),
      body: productView.getIsProductAdded ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // Set the number of columns in the grid
            crossAxisSpacing: 16.0,
            // Set the horizontal spacing between columns
            mainAxisSpacing: 16.0, // Set the vertical spacing between rows
          ),
          itemCount: schoolData.selectedSchool.productsId.length,
          itemBuilder: (context, index) {
            var product = productView.productData[index];
            return GestureDetector(
              onTap: (){
                productData.setProductDetail(product);
                Navigator.pushNamed(context, ProductDescriptionScreen.route);
              },
              child: ReusableColoredBox(
                width: 197,
                height: 220,
                backgroundColor: Colors.white,
                borderColor: Color(0xFFE8E8E8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 188,
                        height: 90,
                        child: Image(image: AssetImage(schoolImages[index]),),
                      ),
                      SizedBox(height: 18,),
                      ReusableText(text: product.name, fontSize: 16, height: 0.10),
                      SizedBox(height: 18,),
                      ReusableText(text: 'Rs ${product.price.toStringAsFixed(2)}', fontSize: 16, height: 0.10),
                      SizedBox(height: 18,),
                      Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              print('Buy Now button tapped');
                            },
                            child: ReusableColoredBox(
                                width: 60,
                                height: 25,
                                backgroundColor: AppColors.primaryColor,
                                borderColor: AppColors.borderColor,
                                child: Center(child: ReusableText(text: 'BUY', fontSize: 16, height: 0.10,color: Colors.white,))),
                          ),

                          GestureDetector(
                              onTap: (){
                                print('add to cart tapped');
                              },
                              child: Icon(Icons.shopping_cart)
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
      ): const Center(
        child: CircularProgressIndicator(),
    )
    );
  }
}
// Card(
// // You can customize the appearance of each grid item using Card, Container, or any other widget
// elevation: 4.0,
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Text(product.name, style: TextStyle(fontSize: 16.0)),
// SizedBox(height: 8.0),
// Text('Rs ${product.price.toStringAsFixed(2)}',
// style: TextStyle(fontSize: 14.0, color: Colors.green)),
// ],
// ),
// ),
// );
// },
// ),
// );
// }
// }


