import 'package:flutter/material.dart';

Row signUpOption() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Don't have an account?",
          style: TextStyle(color: Color(0xFFA5A5A5),)),
      GestureDetector(
        onTap: () {

        },
        child: const Text(
          " Sign Up",
          style: TextStyle(color: Color(0xFF03045E), fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}