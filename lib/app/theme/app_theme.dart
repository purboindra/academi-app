import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final light = ThemeData(
    primaryColor: primaryColor,
    backgroundColor: Color.fromARGB(255, 247, 247, 247),
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: blackColor,
    backgroundColor: backgroundColor,
    brightness: Brightness.dark,
  );
}

const Color primaryColor = Color(0xff602080);
const Color blueColor = Color(0xff202060);
const Color purpleColor = Color(0xffB030B0);
const Color blackColor = Color(0xff202040);
const Color backgroundColor = Color(0xffF9F9F9);
const Color greyColor = Color(0xffDDDDDD);
const Color darkGrey = Color(0xffafafb7);

TextStyle get headingStyle {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  );
}

//