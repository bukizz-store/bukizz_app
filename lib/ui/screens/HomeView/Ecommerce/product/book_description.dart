import 'package:bukizz_1/constants/colors.dart';
import 'package:bukizz_1/ui/screens/HomeView/Ecommerce/product/product_description_screen.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';


class Books extends StatelessWidget {
  const Books({super.key});

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // Set the number of columns in the grid
            crossAxisSpacing: 12.0,
            // Set the horizontal spacing between columns
            mainAxisSpacing: 12.0, // Set the vertical spacing between rows
          ),
          itemCount: 12,
          itemBuilder: (context, index) {


            return InkWell(
              onTap: (){
                Navigator.pushNamed(context, ProductDescriptionScreen.route);
              },
              child:Container(
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
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image(
                        image: AssetImage('assets/school/booksets/${index + 1}.png'),
                        fit: BoxFit.fill,
                        height: dimensions.height105,
                        width: dimensions.width169,
                      ),
                    ),
                    SizedBox(height: dimensions.height24 / 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              text: '2000',
                              style: TextStyle(
                                color: Color(0xFFB7B7B7),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                              ),
                              children: [
                                TextSpan(
                                  text: ' ₹1,600',
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
      ),
    );
  }
}

