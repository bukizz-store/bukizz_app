import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class Dimensions {
  final BuildContext context;

  Dimensions(this.context);

  double get screenHeight => MediaQuery.of(context).size.height;

  double get screenWidth => MediaQuery.of(context).size.width;

  double get width24 => screenWidth / 15.625;

  double get height16 => screenHeight / 50.75;

  double get width327 => screenWidth / 1.147;

  double get height32 => screenHeight / 25.375;

  double get height24 => screenHeight / 33.84;

  double get height10 => screenHeight / 81.2;

  double get height48 => screenHeight / 16.92;

  double get height36 => screenHeight / 22.56;

  double get height8 => screenHeight / 101.5;

  double get height138 => screenHeight / 5.89;
}

//812
//375





