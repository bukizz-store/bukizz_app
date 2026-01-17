import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../constants/colors.dart';
import '../../utils/dimensions.dart';
import '../circle/custom circleAvatar.dart';
import '../text and textforms/Reusable_text.dart';

class CheckoutProcessWidget extends StatelessWidget {
  final int currentStep;

  const CheckoutProcessWidget({
    Key? key,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);

    return Container(
      width: dimensions.screenWidth,
      height: dimensions.height8 * 10,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Step 1
          CustomCircleAvatar(
            radius: dimensions.height8 * 2,
            backgroundColor: currentStep >= 1
                ? AppColors.productButtonSelectedBorder
                : Colors.transparent,
            borderColor: currentStep >= 1
                ? AppColors.productButtonSelectedBorder
                : AppColors.productButtonSelectedBorder,
            borderWidth: currentStep >= 1 ? 0.10 : 0.5,
            fontWeight: currentStep == 1 ? FontWeight.w700 : FontWeight.normal,
            child: ReusableText(
              text: '1',
              fontSize: 16,
              color: currentStep >= 1 ? Colors.white : Color(0xFF058FFF),
              height: null,
            ),
          ),
          Container(
            width: 18.w,
            height: 1.0,
            color: Color(0xFFA5A5A5),
          ),
          // Step 2
          CustomCircleAvatar(
            radius: dimensions.height8 * 2,
            backgroundColor: currentStep >= 2
                ? AppColors.productButtonSelectedBorder
                : Colors.transparent,
            borderColor: currentStep >= 2
                ? AppColors.productButtonSelectedBorder
                : AppColors.productButtonSelectedBorder,
            borderWidth: 0.5,
            text: 'Summary',
            fontWeight: currentStep == 2 ? FontWeight.w700 : FontWeight.normal,
            child: ReusableText(
              text: '2',
              fontSize: 16,
              color: currentStep >= 2 ? Colors.white : Color(0xFF058FFF),
            ),
          ),
          Container(
            width: 18.w,
            height: 1.0,
            color: Color(0xFFA5A5A5),
          ),
          // Step 3
          CustomCircleAvatar(
            radius: dimensions.height8 * 2,
            backgroundColor: currentStep >= 3
                ? AppColors.productButtonSelectedBorder
                : Colors.transparent,
            borderColor: AppColors.productButtonSelectedBorder,
            borderWidth: 0.5,
            text: 'Payment',
            fontWeight: currentStep == 3 ? FontWeight.w700 : FontWeight.normal,
            child: ReusableText(
              text: '3',
              fontSize: 16,
              color: currentStep >= 3 ? Colors.white : Color(0xFF058FFF),
            ),
          ),
        ],
      ),
    );
  }
}
