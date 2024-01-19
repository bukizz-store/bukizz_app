
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/circle/custom circleAvatar.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';

class Checkout3 extends StatefulWidget {
  const Checkout3({super.key});

  @override
  State<Checkout3> createState() => _Checkout3State();
}

class _Checkout3State extends State<Checkout3> {
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: dimensions.height8*1.5,),

            //container with step 1 2 3
            Container(
              width: dimensions.screenWidth,
              height: dimensions.height8*11.5,
              color: Colors.white,
              child:Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensions.width24*1.8),
                child: Row(
                  children: [
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Color(0xFF058FFF),
                      borderColor: Colors.black38,
                      borderWidth: 0.10,
                      child: ReusableText(text: '1', fontSize: 16,color: Colors.white, height: null,),
                    ),
                    Container(
                      width: 90.0,
                      height: 1.0,
                      color: Color(0xFFA5A5A5),
                    ),
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Color(0xFF058FFF),
                      borderColor: Colors.black,
                      borderWidth: 0.5,
                      child: ReusableText(text: '2', fontSize: 16,color: Colors.white),
                    ),
                    Container(
                      width: 90.0,
                      height: 1.0,
                      color: Color(0xFFA5A5A5),
                    ),
                    CustomCircleAvatar(
                      radius: dimensions.height8*2,
                      backgroundColor:Color(0xFF058FFF),
                      borderColor: Colors.black,
                      borderWidth: 0.5,
                      child: ReusableText(text: '3', fontSize: 16,color: Colors.white,),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: dimensions.height8*1.5,),
            Container(
              width: dimensions.screenWidth,
              height: dimensions.height8*6.5,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ReusableText(text: 'Total amount', fontSize: 16,color: Color(0xFF282828),fontWeight: FontWeight.w500,),
                        InkWell(
                          onTap: (){},
                          child: Icon(Icons.arrow_drop_down,color: Color(0xFF282828)),
                        )
                      ],
                    ),
                    ReusableText(text: '₹1,720', fontSize: 20,color: Color(0xFF121212),fontWeight: FontWeight.w700,)
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
