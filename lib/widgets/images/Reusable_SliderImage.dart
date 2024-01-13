import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    Key? key,
    required this.width,
    required this.height,
    this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = Colors.white,
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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Image(
          image: isNetworkImage ? NetworkImage(imageUrl!) : AssetImage(assetImage!) as ImageProvider,
          fit: fit ?? BoxFit.cover,
        ),
      ),
    );
  }
}
