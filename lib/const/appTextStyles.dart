import 'package:flutter/material.dart';
import 'package:local_mart/const/appColors.dart';
import 'package:google_fonts/google_fonts.dart';

class Apptextstyles {
  // headings text

  static final TextStyle headingLarge = GoogleFonts.poppins(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Appcolors.darkBlue,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Appcolors.primaryText,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Appcolors.primaryText,
  );

  // body text
  static final TextStyle bodyLarge = GoogleFonts.doppioOne(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: Appcolors.secondaryText,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: Appcolors.primaryText,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: Appcolors.secondaryText,
  );

  // products text

  static const TextStyle productName = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Appcolors.primaryText,
  );

  static const TextStyle productPrice = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Appcolors.primaryText,
  );

  static const TextStyle oldPrice = TextStyle(
    fontSize: 12,
    decoration: TextDecoration.lineThrough,
    color: Appcolors.secondaryText,
  );

  static const TextStyle discount = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Appcolors.successGreen,
  );

  // Labels & Captions

  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Appcolors.primaryText,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 11,
    color: Appcolors.secondaryText,
  );
}
