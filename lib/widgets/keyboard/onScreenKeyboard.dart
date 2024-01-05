import 'package:flutter/material.dart';

class OnScreenKeyboard extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onKeyTap;
  final double buttonWidth;
  final double buttonHeight;
  final Color buttonColor;

  OnScreenKeyboard({
    required this.controller,
    required this.onKeyTap,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // Row 1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _buildRow(['1', '2', '3']),
          ),
          // Row 2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _buildRow(['4', '5', '6']),
          ),
          // Row 3
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _buildRow(['7', '8', '9']),
          ),
          // Row 4
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              KeyboardButton(
                label: '0',
                onTap: () => onKeyTap('0'),
                width: buttonWidth,
                height: buttonHeight,
                color: buttonColor,
              ),
              BackspaceButton(
                onTap: () {
                  if (controller.text.isNotEmpty) {
                    controller.text = controller.text.substring(0, controller.text.length - 1);
                  }
                },
                width: buttonWidth,
                height: buttonHeight,
                color: buttonColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRow(List<String> labels) {
    return labels.map((label) => KeyboardButton(
      label: label,
      onTap: () => onKeyTap(label),
      width: buttonWidth,
      height: buttonHeight,
      color: buttonColor,
    )).toList();
  }
}

class KeyboardButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color color;

  KeyboardButton({
    required this.label,
    required this.onTap,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
    );
  }
}

class BackspaceButton extends StatelessWidget {
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color color;

  BackspaceButton({
    required this.onTap,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Icon(Icons.backspace),
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
    );
  }
}
