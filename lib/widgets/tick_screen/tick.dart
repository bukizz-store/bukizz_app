import 'package:bukizz/utils/dimensions.dart';
import 'package:bukizz/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../widgets/buttons/Reusable_Button.dart';
import '../../ui/screens/HomeView/Ecommerce/main_screen.dart';

class TickScreen extends StatefulWidget {
  final String text;
  final String secondaryText;
  const TickScreen({super.key, required this.text , required this.secondaryText});

  @override
  State<TickScreen> createState() => _TickScreenState();
}

class _TickScreenState extends State<TickScreen> {
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
      
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: dimensions.height10*10,),
            Center(
              child: Container(
                width: dimensions.width10*10,
                height: dimensions.height10*10,
                decoration: const ShapeDecoration(
                  // color: Color(0xFF00AE11),
                  shape: OvalBorder(),
                ),
                child: SvgPicture.asset('assets/tick.svg'),
              ),
            ),
            SizedBox(height: dimensions.height10*2,),
            ReusableText(text: widget.text, fontSize: 20,fontWeight: FontWeight.w700,color: Color(0xFF121212),),
            SizedBox(height: dimensions.height10*2,),
            ReusableText(text: widget.secondaryText, fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xFF444444),)
      
          ],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.width24),
          child: ReusableElevatedButton(
              width: dimensions.width342,
              height: dimensions.height10*5.4,
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(
                    context, MainScreen.route, (Route<dynamic> route) => false);
              },
              buttonText: 'Back to Home'
          ),
        ),
      ),
    );
  }
}
