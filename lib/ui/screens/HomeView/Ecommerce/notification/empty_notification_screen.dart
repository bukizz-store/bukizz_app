import 'package:bukizz/constants/colors.dart';
import 'package:bukizz/constants/images.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';
import '../main_screen.dart';
import '../profile/add_rating.dart';
import '../profile/queryContact/contact_for_query.dart';

class EmptyNotificationScreen extends StatefulWidget {
  const EmptyNotificationScreen({super.key});

  @override
  State<EmptyNotificationScreen> createState() => _EmptyNotificationScreenState();
}

class _EmptyNotificationScreenState extends State<EmptyNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    BottomNavigationBarProvider provider =
        context.read<BottomNavigationBarProvider>();
    Dimensions dimensions = Dimensions(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (val){
        context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
        return ;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensions.width65*0.7 ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImage.notification),
              SizedBox(
                height: dimensions.height32 * 2,
              ),
              ReusableText(
                text: 'No Notifications Yet',
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
                      'No news yet, but stay tuned for updates, alerts, and more!',
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
                      text: 'Back to Home',
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
      ),
    );
  }
}
