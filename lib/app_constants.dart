import 'package:flutter/material.dart';
class AppTextStyle {
  static const TextStyle smallRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle smallBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle largeBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
}

LinearGradient appGradient() {
  return const LinearGradient(
    colors: [
      
      Color(0xFF4A91FF), // #4A91FF
      Color(0xFF47BFDF), // #47BFDF
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    transform: GradientRotation(
        192.05 * (3.141592653589793 / 180)), // Convert degrees to radians
  );
}
