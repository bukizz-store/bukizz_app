import "package:bukizz_1/constants/colors.dart";
import "package:bukizz_1/data/providers/header_switch.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class HeaderSwitch extends StatefulWidget {
  const HeaderSwitch({super.key, required this.text, required this.icon});

  @override
  State<HeaderSwitch> createState() => _HeaderSwitchState();

  final String text ;
  final IconData icon ;
}

class _HeaderSwitchState extends State<HeaderSwitch>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon , color: Colors.yellow,),
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );

  }
}
