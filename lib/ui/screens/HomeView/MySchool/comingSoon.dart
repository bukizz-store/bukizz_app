import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/images.dart';
import '../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/text and textforms/Reusable_text.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({super.key});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
  Dimensions dimensions = Dimensions(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: dimensions.width65*0.7 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImage.mySchool),
            SizedBox(
              height: dimensions.height32 * 2,
            ),
            ReusableText(
              text: 'My School Coming Soon',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.productButtonSelectedBorder,
            ),
            SizedBox(
              height: dimensions.height29,
            ),
            Flexible(
              child: ReusableText(
                text:
                'Exciting features for your school\'s community are coming soon!',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.schoolTextColor,
                overflow: TextOverflow.visible,
                maxLine: 2,
                height: 1,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: dimensions.height29,),

            InkWell(
              onTap: (){
                context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
              },
              child: Container(
                decoration: BoxDecoration(
                  // color: AppColors.productButtonSelectedBorder,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: AppColors.productButtonSelectedBorder,
                      width: 1
                  ),
                ),
                width: dimensions.width342,
                height: dimensions.height29*2,
                child: Center(
                  child: ReusableText(
                    text: 'Back to My Shop',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.productButtonSelectedBorder,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
