import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/providers/bottom_nav_bar_provider.dart';
import '../main_screen.dart';


class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List colors=[Color(0xFFFF9B05),Color(0xFF00AE11),Color(0xFFFF05AA),Color(0xFF058FFF),Color(0xFFFF9B05),Color(0xFF00AE11)];
  List texts=['Uniforms','Book sets','Notebooks','Art & Craft','School bags','Lunch Box'];
  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    BottomNavigationBarProvider provider = context.read<BottomNavigationBarProvider>();
     return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.read<BottomNavigationBarProvider>().setSelectedIndex(0);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: dimensions.width24,right: dimensions.width16,top: dimensions.height24),
        child: GridView.builder(

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: dimensions.width24/2,
            mainAxisSpacing: dimensions.height8*2,
            mainAxisExtent: dimensions.height10*16.3
          ),
          itemCount: 6,
          itemBuilder: ( context,  index) {
            return Container(
              width: dimensions.width10*10.7,
              height: dimensions.height10*15.3,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.50, color: Color(0xFF66BBFF)),
                  borderRadius: BorderRadius.circular(12),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x1900579E),
                    blurRadius: 12,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: dimensions.width24/2,
                    top: dimensions.height24/2,
                    child: SizedBox(
                      width: dimensions.width10*9.1,
                      child:  Text(
                        texts[index],
                        style: const TextStyle(
                          color: Color(0xFF121212),
                          fontSize: 14,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -dimensions.width10*1.8,
                    top: dimensions.height10*7.5,
                    child: Opacity(
                      opacity: 0.40,
                      child: Container(
                        width: dimensions.width10*14.4,
                        height: dimensions.height10*14.4,
                        decoration:  ShapeDecoration(
                          color:colors[index],
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: dimensions.height24 / 1.95,
                    top: dimensions.width24 * 2,
                    child: Container(
                      width: dimensions.width10 * 8.5,
                      height: dimensions.height10 * 8.5,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage('assets/category/${index + 1}.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
