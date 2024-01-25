import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/product/product_screen.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_TextForm.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/textformAddress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/providers/school_repository.dart';
import '../../../../../data/repository/product_view_repository.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';

class ViewAll extends StatefulWidget {
  static const String route = '/viewall';
  const ViewAll({super.key});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  @override
  Widget build(BuildContext context) {
    TextEditingController formController=TextEditingController();
    var schoolData = Provider.of<SchoolDataProvider>(context, listen: false);
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
         title: Text('Select Your School'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: dimensions.height8),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: dimensions.width16),
            child: CustomTextForm(
              width: dimensions.width342,
              height: dimensions.height8*6,
              controller: formController,
              hintText: 'Enter School name (e.g., DAV School)',
              icon: Icons.search,
            ),
          ),
          SizedBox(height: dimensions.height8*1.5),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: dimensions.width16),
            child: Container(

              height: dimensions.height8*5.2,
              width: dimensions.width16*8.5,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: BorderSide(width: 0.50, color: Color(0xFF00579E)),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(text: 'Kurukshetra', fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFF444444),),
                    Icon(Icons.arrow_drop_down,color: Color(0xFF444444),)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: dimensions.width24/2, vertical: dimensions.height24/2),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: dimensions.width24/3,
                  mainAxisSpacing: dimensions.height8,
                ),
                itemCount: schoolData.schoolData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      schoolData.setSchoolName(schoolData.schoolData[index].name, schoolData.schoolData[index].schoolId);
                      context.read<ProductViewRepository>().getProductData(schoolData.schoolDetails.productsId);
                      Navigator.pushNamed(context, ProductScreen.route);
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: dimensions.height151,
                          width: dimensions.width169,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: const Alignment(-0.00, -1.00),
                              end: const Alignment(0, 1),
                              colors: [Colors.black.withOpacity(0), Colors.black],
                            ),
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
                                color: Color(0x4C00579E),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              schoolData.schoolData[index].banner,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.low,
                              height: dimensions.height151,
                              width: dimensions.width195,
                            ),
                          ),
                        ),
                        Positioned(
                          left: dimensions.width16/2,
                          right: 0,
                          bottom: dimensions.height8*5,
                          child: ReusableText(
                            text: schoolData.schoolData[index].name,
                            fontSize: 14,
                            color: Color(0xFFF9F9F9),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

    );
  }
}

