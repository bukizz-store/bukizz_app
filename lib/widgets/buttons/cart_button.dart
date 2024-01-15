import 'package:bukizz_1/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../containers/Reusable_ColouredBox.dart';
import '../text and textforms/Reusable_text.dart';

class ReusableQuantityButton extends StatelessWidget {
  final int quantity;
  final ValueChanged<int>? onChanged;
  final double height;
  final double width;

  ReusableQuantityButton({
    required this.quantity,
    this.onChanged, required this.height, required this.width,
  });

  @override
  Widget build(BuildContext context) {

    return ReusableColoredBox(
      width: width,
      height: height,
      backgroundColor: Colors.white,
      borderColor: Color(0xFFD6D6D6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Icon(Icons.remove),
            onTap: () {
              if (onChanged != null) {
                if(quantity>0)
                onChanged!(quantity - 1);
              }
            },
          ),
          ReusableText(
            text: '$quantity',
            fontSize: 12,
            height: 0.10,
          ),
          GestureDetector(
            child: Icon(Icons.add),
            onTap: () {
              if (onChanged != null) {
                onChanged!(quantity + 1);
              }
            },
          ),
        ],
      ),
    );
  }
}
