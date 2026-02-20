import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A branded loading screen matching the Bukizz website's loader.
/// Shows the Bukizz book-icon logo with a blue circular spinner below it,
/// on a white background. Fades out smoothly when [isLoading] becomes false.
class BukizzLoader extends StatelessWidget {
  final bool isLoading;

  const BukizzLoader({required this.isLoading, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isLoading,
      child: AnimatedOpacity(
        opacity: isLoading ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Bukizz logo icon
                SvgPicture.asset(
                  'assets/logo_main.svg',
                  width: 60,
                  height: 60,
                ),
                const SizedBox(height: 24),
                // Blue spinner matching the website (color #3B82F6)
                const SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                    backgroundColor: Color(0xFFE5E7EB),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
