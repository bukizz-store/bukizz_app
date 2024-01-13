import 'package:bukizz_1/widgets/text%20and%20textforms/Reusable_text.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final ValueChanged<int>? onIndexChanged;

  const CustomTabBar({Key? key, this.onIndexChanged}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        2,
            (index) => InkWell(
          onTap: () {
            setState(() {
              currentIndex = index;
              widget.onIndexChanged?.call(currentIndex);
            });
          },
          child: Container(
              width: 164,
              height: 44,
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
              decoration: BoxDecoration(
                color: currentIndex == index
                    ?  Color(0xFF058FFF) // Change the color for the selected tab
                    :  Color(0xFFE0CEF7), // Change the color for other tabs
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  index==0?Icon(Icons.shopping_cart):Icon(Icons.school),
                  ReusableText(text: index==0?'Ecommerce':'MySchool', fontSize: 16, height: 0.11,fontWeight: FontWeight.w700,color:currentIndex == index?Color(0xFFF9F9F9):Color(0xFF444444))
                ],
              )
          ),
        ),
      ),
    );
  }
}
