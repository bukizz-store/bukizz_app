import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderShimmer extends StatelessWidget {
  final int itemCount;

  const OrderShimmer({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions = Dimensions(context);

    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          itemCount,
              (index) => Container(
            width: dimensions.screenWidth,
            height: dimensions.height10 * 23, // Adjust height as needed
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dimensions.width24 / 4,
                vertical: dimensions.height8 / 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: dimensions.width10 * 10, // Adjust width as needed
                    height: dimensions.height10, // Adjust height as needed
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 4),
                  Container(
                    width: 30,
                    height: 10,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 130,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 110,
                        height: 30,
                        color: Colors.grey[300],
                      ),
                      Container(
                        width: 110,
                        height: 30,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
