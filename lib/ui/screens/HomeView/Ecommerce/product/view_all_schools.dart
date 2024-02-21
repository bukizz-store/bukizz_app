import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/constants/font_family.dart';
import 'package:bukizz/data/models/ecommerce/school_model.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/product_screen.dart';
import 'package:bukizz/utils/dimensions.dart';
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
  List<SchoolModel> foundedSchool = [];
  final TextEditingController _schoolNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foundedSchool = Provider.of<SchoolDataProvider>(context, listen: false).schoolData;
  }


  void _runFilter(String word){
    var schoolData = Provider.of<SchoolDataProvider>(context, listen: false);
    print(word);
    List<SchoolModel> results = [];
    if(word.isEmpty){
      results = List.from(schoolData.schoolData);
    }else{
      //write the logic to search the school name in the list of schoolModel and store the result in results
      results = schoolData.schoolData.where((element) => element.name.toLowerCase().contains(word.toLowerCase())).toList();
    }
    setState(() {
      foundedSchool = results;
    });
  }

  @override
  Widget build(BuildContext context) {

    var schoolData = Provider.of<SchoolDataProvider>(context, listen: false);
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
         title: ReusableText(text: 'Select Your School', fontSize: 18,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: dimensions.height8),
          // Padding(
          //   padding:EdgeInsets.symmetric(horizontal: dimensions.width16),
          //   child: CustomTextForm(
          //     width: dimensions.width342,
          //     height: dimensions.height8*6,
          //     controller: formController,
          //     hintText: 'Enter School name (e.g., DAV School)',
          //     icon: Icons.search,
          //   ),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Icon(Icons.arrow_back),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: dimensions.width16),
                child:  SizedBox(
                  width: MediaQuery.of(context).size.width ,
                  height: dimensions.height10 * 4.4,
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    controller: _schoolNameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search , color: AppColors.productButtonSelectedBorder,),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: dimensions.height8 * 2),
                      hintText: 'Enter School name (e.g., DAV School)',
                      hintStyle: const TextStyle(color: Color(0xFF7A7A7A),fontFamily: 'nunito'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            dimensions.height10 * 4.4 / 2),
                        borderSide: const BorderSide(color: Color(0xFF7A7A7A)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            dimensions.height10 * 4.4 / 2),
                        borderSide: const BorderSide(color: Colors.black38),
                      ),
                    ),
                  ),
                ),
              ),
          //   ],
          // ),
          SizedBox(height: dimensions.height8*1.5),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: dimensions.width24/2, vertical: dimensions.height24/2),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: dimensions.width24/3,
                  mainAxisSpacing: dimensions.height8,
                ),
                itemCount: foundedSchool.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      schoolData.setSchoolName(foundedSchool[index].name, foundedSchool[index].schoolId);
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
                              foundedSchool[index].banner,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.low,
                              height: dimensions.height151,
                              width: dimensions.width195,
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: dimensions.width16,
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 30),
                                height: dimensions.height10*7,
                                width: dimensions.width169,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: const Alignment(
                                          0.00, -1.00),
                                      end: const Alignment(0, 0),
                                      colors: [
                                        Colors.black.withOpacity(0),
                                        Colors.black
                                      ],
                                    ),
                                    borderRadius:
                                    const BorderRadius.only(
                                        bottomLeft:
                                        Radius.circular(12),
                                        bottomRight:
                                        Radius.circular(12))),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    ReusableText(
                                      text: foundedSchool[index].name,
                                      fontSize: 14,
                                      color: Color(0xFFF9F9F9),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(
                                      height: dimensions.height10,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width:
                                          dimensions.width24 / 6,
                                        ),
                                        ReusableText(
                                          text: schoolData
                                              .schoolData[index].city,
                                          fontSize: 12,
                                          color: Color(0xFFF9F9F9),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    )
                                  ],
                                )))
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

