import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/profile/add_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants/font_family.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../widgets/text and textforms/Reusable_text.dart';

class KnowMoreScreen extends StatefulWidget {
  static const route = '/knowmore';
  const KnowMoreScreen({super.key});

  @override
  State<KnowMoreScreen> createState() => _KnowMoreScreenState();
}

class _KnowMoreScreenState extends State<KnowMoreScreen> {
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: dimensions.height16,
              color: Color(0xFFE0F0FF),
            ),
            Container(
                width: dimensions.screenWidth,
                height: dimensions.screenHeight,
                color: Colors.white,
                child:Padding(
                  padding: EdgeInsets.symmetric(horizontal:dimensions.height8,vertical: dimensions.width24/2),
                  child: Container(
                    width: dimensions.width10*39.3,
                    height: dimensions.height10*37.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ReusableText(text: 'Your order is', fontSize: 16,color: Color(0xFF444444),fontWeight: FontWeight.w700,),
                            SizedBox(width: dimensions.width10/2,),
                            ReusableText(text: 'Delivered', fontSize: 16,color: Color(0xFF444444),fontWeight: FontWeight.w700,),
                          ],
                        ),
                        SizedBox(height: dimensions.height8*2,),
                        ReusableText(text: '1 Day ago', fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFF7A7A7A),),
                        SizedBox(height: dimensions.height8*2,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: dimensions.width10*7.6,
                              height: dimensions.height10*7.6,
                              child: SvgPicture.asset('assets/school/booksets/1.svg',fit: BoxFit.cover,color: Colors.red,),
                            ),
                            SizedBox(width: dimensions.width16,),
                            SizedBox(
                              width: dimensions.width10*25.2,
                              child: const Text(
                                'Your product English Book Set - Wisdom World School - Class 1st is delivered',
                                style: TextStyle(
                                  color: Color(0xFF444444),
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: dimensions.height8*2,),
                        Container(
                          height: dimensions.height10*3.5,
                          width: dimensions.width342,
                          child: OutlinedButton(
                            onPressed: () {
                             Navigator.pushNamed(context, RatingsScreen.route);
                            },
                            style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Color(0xFF00579E), ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: dimensions.width10*4)
                            ),
                            child: ReusableText(
                              text: 'Add Review',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7A7A7A),
                            ),
                          ),
                        ),

                        SizedBox(height: dimensions.height8*3,),
                        //price distribution
                        Container(
                          width: dimensions.screenWidth,
                          height: null,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(text: 'Price Detailes', fontSize: 16,color: Color(0xFF282828),fontWeight: FontWeight.w700,),
                              SizedBox(height: dimensions.height8*3,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableText(text: 'Price (2 items) ', fontSize: 12,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w500,),
                                  ReusableText(text: '₹.2080', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500, )
                                ],
                              ),
                              SizedBox(height: dimensions.height8*2.5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableText(text: 'Discount', fontSize: 12,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w500,fontFamily: FontFamily.roboto,),
                                  ReusableText(text: '-₹400', fontSize: 12,color: Color(0xFF038B10),fontWeight: FontWeight.w500,fontFamily: FontFamily.roboto,)
                                ],
                              ),
                              SizedBox(height: dimensions.height8*2.5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableText(text: 'Delivery Charges', fontSize: 12,color: Color(0xFF7A7A7A),fontWeight: FontWeight.w500,fontFamily: FontFamily.roboto,),
                                  ReusableText(text: '₹40', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500,fontFamily: FontFamily.roboto,)
                                ],
                              ),
                              SizedBox(height: dimensions.height8*1.5,),
                              Container(
                                width: dimensions.width24*14,
                                height: 1,
                                color: Color(0xFFD6D6D6),
                              ),
                              SizedBox(height: dimensions.height8*2.5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ReusableText(text: 'Total Amount', fontSize: 14,color: Color(0xFF282828),fontWeight: FontWeight.w700,fontFamily: FontFamily.roboto,),
                                  ReusableText(text: '₹500', fontSize: 12,color: Color(0xFF121212),fontWeight: FontWeight.w500,fontFamily: FontFamily.roboto,)
                                ],
                              ),
                              SizedBox(height: dimensions.height8*1.5,),
                              Container(
                                width: dimensions.width24*14,
                                height: 1,
                                color: Color(0xFFD6D6D6),
                              ),
                              SizedBox(height: dimensions.height8*1.5,),
                              ReusableText(text: 'You will save ₹40 on this order', fontSize: 12,color: Color(0xFF038B10),fontWeight: FontWeight.w600,fontFamily: FontFamily.roboto,)
                            ],
                          ),
                        ),

                        SizedBox(height: dimensions.height8*3,),
                        Container(
                          width: dimensions.width24*14,
                          height: 1,
                          color: Color(0xFFD6D6D6),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
