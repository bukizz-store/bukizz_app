import 'package:bukizz/utils/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../../data/repository/category/category_repository.dart';
import '../../../../../data/repository/product/general_product.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';
import '../main_screen.dart';
import '../product/Stationary/general_product_screen.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List colors=[Color(0xFFFF9B05),Color(0xFF00AE11),Color(0xFFFF05AA),Color(0xFF058FFF),Color(0xFFFF9B05),Color(0xFF00AE11)];
  List texts=['NoteBook Set','Stationar Kit','Bag','Lunch Box'];
  @override
  Widget build(BuildContext context) {
    var categoryRepo = Provider.of<CategoryRepository>(context, listen: false);
    Dimensions dimensions=Dimensions(context);
    BottomNavigationBarProvider provider = context.read<BottomNavigationBarProvider>();
     return PopScope(
       canPop: false,
       onPopInvoked: (val){
         context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
         return ;
       },
       child: Scaffold(
        appBar: AppBar(
          title: ReusableText(text: 'Categories',fontSize: 20,fontWeight: FontWeight.w500,),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,size: 20,),
            onPressed: () {
              context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: dimensions.width24,right: dimensions.width16,top: dimensions.height24),
          child: GridView.builder(

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              mainAxisExtent: 55.sp
            ),
            itemCount: categoryRepo.category.length,//categoryRepo.category.length
            itemBuilder: ( context,  index) {
              var selectedModel=categoryRepo.category[index];
              return GestureDetector(
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
                                  product: selectedModel.name)));
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
                        width: 55.sp,
                        height: 40.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                         // border: Border.all(color: Colors.grey.withOpacity(0.6),width: 0.5)
                        ),
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: selectedModel.image,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: dimensions.width24 / 3,
                            vertical: dimensions.height10 * 2),
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
              );
            },
          ),
        ),
           ),
     );
  }
}
