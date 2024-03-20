import 'package:bukizz/data/models/ecommerce/school_model.dart';
import 'package:bukizz/data/repository/product/uniform.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/Uniform/uniform_description_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../../widgets/text and textforms/Reusable_text.dart';
import '../../../../../../widgets/text and textforms/textformAddress.dart';
import '../../main_screen.dart';


class UniformScreen extends StatefulWidget {
  const UniformScreen({super.key});

  @override
  State<UniformScreen> createState() => _UniformScreenState();
}

class _UniformScreenState extends State<UniformScreen> {
  @override
  Widget build(BuildContext context) {
    List<String>stationaryText=[
      'School uniform',
      'Track Suit',
      'Boys Grey Trouser',
      'Unisex Blue Blazer',
    ];
    // List<String>stationarySubText=[
    //   'Min 50% off',
    //   '@ RS.200',
    //   '@ RS.200',
    //   '@ RS.200',
    // ];
    TextEditingController formController=TextEditingController();
    Dimensions dimensions=Dimensions(context);
    var uniformData = context.read<UniformRepository>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: dimensions.height8*2.5),
            uniformData.uniform.length>0?
            Container(
              width: dimensions.screenWidth,
              height: dimensions.screenHeight,
              child:  GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // crossAxisSpacing: dimensions.width24/3,
                    mainAxisSpacing: dimensions.height8,
                  ),
                  itemCount: uniformData.uniform.length,
                  itemBuilder: (context, index) {

                    return GestureDetector(
                      onTap: (){
                        context.read<UniformRepository>().selectedUniform = context.read<UniformRepository>().uniform[index];
                        Navigator.pushNamed(context, UniformDescriptionScreen.route);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: dimensions.width24/2,vertical: dimensions.height10/2),
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
                              width: dimensions.width10*16.8,
                              height: dimensions.height10*9.5,

                              child: ClipRRect(
                                  borderRadius:BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                  child: CachedNetworkImage(
                                    imageUrl: uniformData.uniform[index].variation['0']['0'].image[0],
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: dimensions.width24/2,vertical: dimensions.height10*2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ReusableText(text: uniformData.uniform[index].name, fontSize: 14,color: Color(0xFF444444),fontWeight: FontWeight.w500,),
                                  SizedBox(height: dimensions.height10*2,),
                                  ReusableText(text: 'Min 50% Off', fontSize: 14,color:  Color(0xFF121212),fontWeight: FontWeight.w700,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );

                  }
              ),
            ):
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 28.sp,),
                  Container(
                    width:60.sp,
                    height: 60.sp,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.withOpacity(0.1))
                    ),
                    child:Image.asset('assets/emptyUniform.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Uniforms Coming Soon',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF00579E),
                    ),
                  ),
                  SizedBox(height:20),
                   SizedBox(
                    width: 70.sp,
                    child: const Text(
                      'We\'re working hard to bring you the perfect uniforms. Check back soon!',
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  ElevatedButton(
                      onPressed: (){
                        context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
                        Navigator.pushNamed(context, MainScreen.route);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 35.sp),
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: Color(0xFF00579E)),
                      ),
                      child: ReusableText(text: 'Back to Home', fontSize: 16,color: Color(0xFF00579E),fontWeight: FontWeight.w700,)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
