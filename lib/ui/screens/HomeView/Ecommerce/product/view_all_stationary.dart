import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/colors.dart';
import '../../../../../data/repository/category/category_repository.dart';
import '../../../../../data/repository/product/general_product.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';
import '../../../../../widgets/text and textforms/textformAddress.dart';
import 'Stationary/general_product_screen.dart';

class ViewAllStationaryScreen extends StatefulWidget {
  static const String route = '/viewallstationary';
  const ViewAllStationaryScreen({super.key});

  @override
  State<ViewAllStationaryScreen> createState() => _ViewAllStationaryScreenState();
}

class _ViewAllStationaryScreenState extends State<ViewAllStationaryScreen> {
  @override
  Widget build(BuildContext context) {
    List<String>stationaryText=[
      'School Bags',
      '18 Notebook set',
      'Lunchbox set',
      'Lunchboxtext',
    ];
    List<String>stationarySubText=[
      'Min 50% off',
      '@ RS.200',
      '@ RS.200',
      '@ RS.200',
    ];
    TextEditingController formController=TextEditingController();
    Dimensions dimensions=Dimensions(context);
    var categoryRepo = Provider.of<CategoryRepository>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy stationary'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: dimensions.height8),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: dimensions.width16),
              child: CustomTextForm(
                width: dimensions.width342,
                height: dimensions.height8*6,
                controller: formController,
                hintText: 'Enter School bags,lunch box',
                icon: Icons.search,
              ),
            ),

            SizedBox(height: dimensions.height8*1.5),

            Container(
              width: dimensions.screenWidth,
              height: dimensions.screenHeight,
              padding: EdgeInsets.only(left: dimensions.width16),
              child:  GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // crossAxisSpacing: dimensions.width24/3,
                    mainAxisSpacing: dimensions.height8,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    var selectedModel=categoryRepo.category[index];
                    return  categoryRepo.category.isNotEmpty?
                    GestureDetector(
                      onTap: () {
                        context.read<CategoryRepository>().selectedCategory = selectedModel;
                        context.read<GeneralProductRepository>().getGeneralProductFromFirebase(selectedModel.categoryId);
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>   GeneralProductScreen(product: selectedModel.name)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: dimensions.width16,bottom: dimensions.height10),
                        width: dimensions.width146,
                        height: dimensions.height10,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 0.50,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFFD6D6D6),
                            ),
                            borderRadius: BorderRadius.circular(12),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: dimensions.width146,
                              height: dimensions.height10 * 9,
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12)),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover, imageUrl: selectedModel.image,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: dimensions.width24 / 3,
                                  vertical: dimensions.height10 * 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReusableText(
                                    text: selectedModel.name,
                                    fontSize: 14,
                                    color: Color(0xFF444444),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    height: dimensions.height10 * 2,
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
                    ):const Center(child: SpinKitChasingDots(color: AppColors.primaryColor, size: 24,));
                  }
              ),
            )
          ],
        ),
      ),

    );
  }
}
