import 'package:bukizz_1/constants/colors.dart';
import 'package:bukizz_1/utils/dimensions.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final int minLines;
  final String title;

  ExpandableTextWidget({required this.text, this.minLines = 4 , this.title = ''});

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Dimensions dimensions=Dimensions(context);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: dimensions.width24,vertical: dimensions.height8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.text,
              maxLines: isExpanded ? null : widget.minLines,
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF444444),
              ),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Row(
                children: [
                  Text(
                    isExpanded ? 'See Less' : 'See More',
                    style: const TextStyle(
                      color: Color(0xFF00579E),
                    ),
                  ),
                  Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,color: Color(0xFF00579E),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


