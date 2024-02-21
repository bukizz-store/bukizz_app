import 'package:bukizz/ui/screens/HomeView/Ecommerce/product/Stationary/Bags/bag_description.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../../../../../widgets/text and textforms/Reusable_text.dart';

List bagImages=['bag1','bag1','bag1','bag1','bag1','bag1'];
class BagViewAll extends StatefulWidget {
  static const route = '/stationary view';
  const BagViewAll({super.key});

  @override
  State<BagViewAll> createState() => _BagViewAllState();
}

class _BagViewAllState extends State<BagViewAll> {
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensions.width24/2,vertical: dimensions.height24 ),
          child: GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: dimensions.width24/1.5,
                  mainAxisSpacing: dimensions.height8*2,

                  mainAxisExtent: dimensions.height10*17
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                      Navigator.pushNamed(context, BagDescriptionScreen.route);
                  },
                  child: Container(
                    height: dimensions.height105,
                    width: dimensions.width169,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          alignment: Alignment.center,
                          width: dimensions.width169,
                          height: dimensions.height105 * 0.95,
                          child: Image.asset('assets/bags/${bagImages[index]}/1.jpg'),
                        ),
                        SizedBox(height: dimensions.height24 / 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  text: 'Rs 1300',
                                  style: TextStyle(
                                    color: Color(0xFFB7B7B7),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    fontFamily: 'nunito',
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' ₹ 1199',
                                      style: TextStyle(
                                        color: Color(0xFF121212),
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.none,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: dimensions.height24 / 3),
                              ReusableText(
                                text: '20 % off',
                                fontSize: 12,
                                height: 0.11,
                                color: Color(0xFF058FFF),
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: dimensions.height24 / 3),
                              Row(
                                children: List.generate(
                                  5,
                                      (index) => Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Color(0xFF058FFF),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                );
              }
          )
      ),
    );
  }
}
