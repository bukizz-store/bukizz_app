import 'package:bukizz/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    Key? key,
    required this.width,
    required this.height,
    this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = Colors.transparent,
    this.fit = BoxFit.fill,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = 8,
    this.assetImage,
  }) : super(key: key);

  final double width;
  final double height;
  final String? assetImage;
  final String? imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: dimensions.width16),
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? Image.network(
            imageUrl!,
            fit: fit ?? BoxFit.contain,
          )
              : Image.asset(
            assetImage!,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
