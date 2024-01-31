import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/profile/add_rating.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/profile/know_more.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/font_family.dart';
import '../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../../../../../utils/dimensions.dart';
import '../main_screen.dart';

class OrderScreen extends StatefulWidget {
  static const route = '/order';
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int itemCount=2;
  @override
  Widget build(BuildContext context) {
    BottomNavigationBarProvider provider = context.read<BottomNavigationBarProvider>();
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: dimensions.height16,
              color: Color(0xFFE0F0FF),
            ),
            Container(
              padding:EdgeInsets.symmetric(horizontal: dimensions.width24/4,vertical: dimensions.height8/2),
              width: dimensions.screenWidth,
              height: dimensions.height10*23*itemCount,
              color: Colors.white,
              child:ListView.builder(
                  itemCount: itemCount,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder:(context,index){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal:dimensions.height8,vertical: dimensions.width24/2),
                      child: Container(
                        width: dimensions.width10*39.3,
                        height: dimensions.height10*20,
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
                                  width: dimensions.width10 * 7.6,
                                  height: dimensions.height10 * 7.6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      dimensions.width10 ,
                                    ),

                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      dimensions.width10 ,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/school/booksets/${index + 1}.svg',
                                      fit: BoxFit.cover,
                                      color: Colors.red,
                                    ),
                                  ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                   Navigator.pushNamed(context, KnowMoreScreen.route);
                                  },
                                  style: OutlinedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        side: BorderSide(color: Color(0xFF00579E), ),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: dimensions.width10*4)
                                  ),
                                  child: ReusableText(
                                    text: 'Know More',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF7A7A7A),
                                  ),
                                ),
                                OutlinedButton(
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
                              ],
                            ),

                          ],
                        ),
                      ),
                    );
                  }
              )
            ),
          ],
        ),
      ),
    );
  }
}

