import 'package:bukizz/constants/constants.dart';
import 'package:bukizz/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz/ui/screens/HomeView/homeScreen.dart';
import 'package:bukizz/ui/screens/Signup%20and%20SignIn/Signin_Screen.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/buttons/Reusable_Button.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../data/providers/school_repository.dart';
import '../main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String route = '/onboardingscreen';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  late PageController _pageController;
  int _currentPage = 0;

  List texts=['Book & Go!', 'Explore & Enroll!', 'Stay Informed, Stay Ahead!'];
  List subTexts=['Order your school books & essentials, delivered straight home.','Find your dream school, fill forms online, and get ready for success.', 'Track progress, manage fees, and connect with your school – all in one place.'];

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

    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page! as int;
      });
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access MediaQuery and update animation values
    Dimensions dimensions = Dimensions(context);
    animation = Tween<double>(
      begin: dimensions.height10 * 40,
      end: dimensions.height10 * 4,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeOutQuart),
      ),
    );
  }

  Future<void> checkCurrentUser() async {
    if (AppConstants.isLogin && AppConstants.userData.toString().isNotEmpty) {
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
            top: animation.value+dimensions.height10*3,
            child: SvgPicture.asset('assets/logo.svg')
          ),
          Positioned(
            // left: dimensions.width10*2.4,
            top: animation.value*2+dimensions.height10*15,
            child:Column(
              children: [
                Container(
                  width: dimensions.width10*30.5+dimensions.width24,
                  height: dimensions.height10*28.4+dimensions.height24,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      setState(() {
                        // Update the current page index
                        _currentPage = index;
                      });
                    },
                    children: [
                      _buildOnboardingPage('assets/onboarding/deliveryBoy.jpg'),
                      _buildOnboardingPage('assets/onboarding/2.jpg'),
                      _buildOnboardingPage('assets/onboarding/3.jpg'),
                    ],
                  ),
                ),
                SizedBox(height: dimensions.height16,),

                SizedBox(
                  width: dimensions.screenWidth-dimensions.width10*2,
                  child:  Text(
                    texts[_currentPage],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                  width: dimensions.screenWidth-dimensions.width10*2,
                  child:  Text(
                   subTexts[_currentPage],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF444444),
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                SizedBox(height: dimensions.height10,),
                DotsIndicator(
                  dotsCount: 3,
                  position: _currentPage,

                  decorator: DotsDecorator(
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(95.27),
                    ),
                    activeColor: Color(0xFF39A7FF),
                    activeSize: Size(dimensions.width10*3.6, 8),
                  ),
                )

              ],
            )
          ),
         Positioned(
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
          )
        ],
      )
    );
  }

  Widget _buildOnboardingPage(String imagePath) {
    Dimensions dimensions=Dimensions(context);
    return  Container(
      padding: EdgeInsets.all(dimensions.width10),
      width: dimensions.width10*30.5,
      height: dimensions.height10*28.4,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),

      child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(imagePath,fit: BoxFit.cover,)
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
