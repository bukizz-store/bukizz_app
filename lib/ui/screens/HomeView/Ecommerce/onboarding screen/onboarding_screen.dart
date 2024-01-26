import 'package:bukizz_1/constants/constants.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz_1/ui/screens/HomeView/homeScreen.dart';
import 'package:bukizz_1/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/buttons/Reusable_Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../data/providers/school_repository.dart';

class OnboardingScreen extends StatefulWidget {
  static const String route = '/onboardingscreen';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;



  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3))
      ..addListener(() {
        setState(() {});
      })
      ..forward();
    final double intervalStart = 0.5; // Logo displayed for the first half second
    final double intervalEnd = 1.0; // Button sliding in during the second half second
    animation = Tween<double>(begin: 400.0, end: 40.0)
        .animate(CurvedAnimation(
        parent: animationController, curve: Interval(intervalStart, intervalEnd, curve: Curves.easeOutQuart)));

    navigateToNext();
  }

  navigateToNext() {
    Future.delayed(const Duration(seconds: 4), () async {
      await checkCurrentUser();
    });
  }


  Future<void> checkCurrentUser() async {
    if (AppConstants.isLogin && AppConstants.userData.uid != '') {
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.route, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);
    var schoolData = Provider.of<SchoolDataProvider>(context, listen: false);
    schoolData.loadData(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            // left: dimensions.width10*11.5,
            top: animation.value,
            child: SvgPicture.asset('assets/logo.svg')
          ),
          Positioned(
            // left: dimensions.width10*2.4,
            top: animation.value*2+dimensions.height10*15,
            child:Column(
              children: [
                Container(
                  width: dimensions.width10*30.5,
                  height: dimensions.height10*28.4,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  // child: SvgPicture.asset('assets/deliveryboy.svg',fit: BoxFit.cover,),
                  child: Image.asset('assets/onboarding/deliveryBoy.jpg'),
                ),
                SizedBox(height: dimensions.height16,),
                SizedBox(
                  width: dimensions.width10*30.5,
                  child: const Text(
                    'Book & Go!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF121212),
                      fontSize: 24,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      height: 0.05,
                    ),
                  ),
                ),
                SizedBox(height: dimensions.height16,),
                SizedBox(
                  width: dimensions.width10*30.5,
                  child: const Text(
                    'Order your school books & essentials, delivered straight home.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF444444),
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                )
              ],
            )
          ),
          !AppConstants.isLogin ?  Positioned(
            left: dimensions.width10*4,
            right:dimensions.width10*4,
            top: animation.value*5+dimensions.height10*50,
            child: ReusableElevatedButton(
              width: dimensions.width342,
              height: dimensions.height16*3.5,
              onPressed: () {
                Navigator.pushNamed(context, SignIn.route);
              },
              buttonText: 'Get Started',
            )
          ): Container()
        ],
      )
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
