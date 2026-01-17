import 'package:flutter/material.dart';

class FastNavigation {
  /// Ultra-fast navigation with zero animation delay
  static void pushInstant(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: Duration.zero, // No animation delay
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // No transition animation
        },
      ),
    );
  }

  /// Fast navigation with minimal animation (50ms instead of 300ms)
  static void pushFast(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 50), // Very fast
        reverseTransitionDuration: const Duration(milliseconds: 50),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut, // Smooth but fast
            )),
            child: child,
          );
        },
      ),
    );
  }

  /// Ultra-fast named route navigation
  static void pushNamedInstant(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  /// Fast replace navigation (no back stack)
  static void pushReplacementInstant(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

  /// Fast navigation with fade transition
  static void pushFade(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 100),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}