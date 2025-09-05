import 'package:flutter/material.dart';

class DeliveryDateWidget extends StatelessWidget {
  final int deliveryDays;
  final double iconSize;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final Color iconColor;

  const DeliveryDateWidget({
    Key? key,
    this.deliveryDays = 2,
    this.iconSize = 16,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w500,
    this.textColor = const Color(0xFF038B10),
    this.iconColor = const Color(0xFF038B10),
  }) : super(key: key);

  String _getMonthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month];
  }

  String _getWeekdayName(int weekday) {
    const weekdays = [
      '',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    return weekdays[weekday];
  }

  @override
  Widget build(BuildContext context) {
    DateTime deliveryDate = DateTime.now().add(Duration(days: deliveryDays));

    return Row(
      children: [
        Icon(
          Icons.local_shipping,
          color: iconColor,
          size: iconSize,
        ),
        SizedBox(width: 4),
        Text(
          "Delivered by ${deliveryDate.day} ${_getMonthName(deliveryDate.month)}, ${_getWeekdayName(deliveryDate.weekday)}",
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
