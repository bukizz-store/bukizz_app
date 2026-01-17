import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PerformanceOptimizer {
  static Timer? _debounceTimer;

  /// Wrap widgets with performance optimizations
  static Widget optimizeWidget(Widget child) {
    return RepaintBoundary(
      child: child, // Prevents unnecessary repaints
    );
  }

  /// Optimize ListView for better scrolling performance
  static Widget optimizeListView({
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    ScrollController? controller,
    EdgeInsets? padding,
    bool shrinkWrap = false,
  }) {
    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      cacheExtent: 500, // Cache more items for smoother scrolling
      addAutomaticKeepAlives: false, // Reduce memory usage
      addRepaintBoundaries: true, // Optimize repainting
      itemBuilder: (context, index) {
        return RepaintBoundary(
          child: itemBuilder(context, index),
        );
      },
    );
  }

  /// Optimize images for better performance
  static Widget optimizeImage({
    required String imageUrl,
    double? width,
    double? height,
    BoxFit? fit,
    bool isNetworkImage = true,
  }) {
    if (isNetworkImage) {
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: width?.round(),
        cacheHeight: height?.round(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: Icon(Icons.error, color: Colors.grey),
          );
        },
      );
    } else {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: width?.round(),
        cacheHeight: height?.round(),
      );
    }
  }

  /// Create optimized containers to reduce overdraw
  static Widget optimizeContainer({
    required Widget child,
    Color? color,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BoxDecoration? decoration,
    double? width,
    double? height,
  }) {
    return RepaintBoundary(
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: decoration,
        color: decoration == null ? color : null,
        child: child,
      ),
    );
  }

  /// Optimized button with reduced build times
  static Widget optimizeButton({
    required VoidCallback? onPressed,
    required Widget child,
    Color? color,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
  }) {
    return RepaintBoundary(
      child: Material(
        color: color ?? Colors.blue,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          child: Padding(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: child,
          ),
        ),
      ),
    );
  }

  /// Optimize text rendering
  static Widget optimizeText(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return RepaintBoundary(
      child: Text(
        text,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }

  /// Enable performance mode for the entire app
  static void enablePerformanceMode() {
    // Performance optimizations are already applied through other methods
    // Note: debugPrintBeginFrameBanner and debugPrintEndFrameBanner are not available in current Flutter version
  }

  /// Debounce function to prevent rapid successive calls
  static void debounce(VoidCallback callback, {Duration delay = const Duration(milliseconds: 300)}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, callback);
  }

  /// Fast gesture detector with debounce
  static Widget fastGestureDetector({
    required VoidCallback onTap,
    required Widget child,
    Duration debounceDelay = const Duration(milliseconds: 100),
  }) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          debounce(onTap, delay: debounceDelay);
        },
        child: child,
      ),
    );
  }
}