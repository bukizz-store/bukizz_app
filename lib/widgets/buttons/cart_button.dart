import 'package:bukizz/constants/strings.dart';
import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../data/providers/cart_provider.dart';
import '../containers/Reusable_ColouredBox.dart';
import '../text and textforms/Reusable_text.dart';

class ReusableQuantityButton extends StatelessWidget {
  final int quantity;
  final ValueChanged<int>? onChanged;
  final double height;
  final double width;
  final String productId;
  final String schoolName;
  final String set;
  final String stream;

  ReusableQuantityButton({
    required this.quantity,
    this.onChanged, required this.height, required this.width,
    required this.schoolName,
    required this.set,
    required this.stream,
required this.productId
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFFD6D6D6)),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Icon(Icons.remove,color:  Color(0xFF00579E),),
            onTap: () {
              if (onChanged != null) {
                // if(quantity>0)
                onChanged!(quantity - 1);
                context.read<CartProvider>().removeSingleCartData(schoolName ,productId, context ,set , stream, 1);
              }
            },
          ),
          ReusableText(
            text: '$quantity',
            fontSize: 12,
            height: 0.10,
            color: Color(0xFF00579E),
          ),
          GestureDetector(
            child: Icon(Icons.add,color: Color(0xFF00579E),),
            onTap: () async {
              if (onChanged != null) {
                onChanged!(quantity + 1);
                await context.read<CartProvider>().addProductInCart(schoolName,set , stream, 1, productId, context , stream == 'null' ? AppString.generalType : AppString.bookSetType).then((value) => AppConstants.showCartSnackBar(context));
              }
            },
          ),
        ],
      ),
    );
  }
}
