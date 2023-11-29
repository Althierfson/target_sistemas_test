import 'package:flutter/material.dart';
import 'package:target_sistemas_test/custom_colors.dart';

class CustomTheme {
  static ThemeData get theme => ThemeData(
    snackBarTheme: SnackBarThemeData(
      backgroundColor: CustomColors.mediumSeaGreen
    )
  );
}
