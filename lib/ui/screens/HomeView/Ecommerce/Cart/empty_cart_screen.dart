import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/ecommerce_home.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/main_screen.dart';
import 'package:bukizz_1/ui/screens/HomeView/homeScreen.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'cart_screen.dart';

class EmptyCart extends StatefulWidget {
  const EmptyCart({super.key});

  @override
  State<EmptyCart> createState() => _EmptyCartState();
}

class _EmptyCartState extends State<EmptyCart> {
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: dimensions.height240,),
              Container(
                width: dimensions.width244,
                height: dimensions.height40*4.5,
                child: SvgPicture.asset('assets/cart/emptyCart.svg'),
              ),
               SizedBox(
                width: dimensions.width10*22,
                child: const Text(
                  'Hmmm... looks like your cart is Empty.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF7A7A7A),
                    fontSize: 20,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
               ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacementNamed(context,HomeScreen.route);
                  },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.transparent,
                       side: BorderSide(color: Color(0xFF00579E)),
                   ),
                 child: ReusableText(text: 'Keep Exploring', fontSize: 16,color: Color(0xFF00579E),fontWeight: FontWeight.w700,)
               ),
            ],
          ),
        ),
      ),
    );
  }
}
