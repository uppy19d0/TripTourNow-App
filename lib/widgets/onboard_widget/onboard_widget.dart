import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../utils/dimensions.dart';
import '../../utils/size.dart';

class OnboardWidget extends StatelessWidget {
  const OnboardWidget({
    super.key,
    required this.img,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.bgColor,
    this.titleColor,
    this.subTitleColor,
    this.detailsColor,
  });
  final String img, text1, text2, text3;
  final Color bgColor;
  final Color? titleColor, subTitleColor, detailsColor;
  @override
  Widget build(BuildContext context) {
  

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: bgColor,
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimensions.defaultPaddingSize * 0.4,
          right: Dimensions.defaultPaddingSize,
        ),
        child: Column(
          mainAxisAlignment: mainCenter,
          crossAxisAlignment: crossStart,
          children: [
            Image.asset(img),
            Text(
              text1,
              style: GoogleFonts.inter(
                  fontSize: Dimensions.onboardsubTitle,
                  fontWeight: FontWeight.w500,
                  color: subTitleColor),
            ),
            Text(
              text2,
              style: GoogleFonts.inter(
                fontSize: Dimensions.titleText,
                fontWeight: FontWeight.w700,
                color: titleColor,
              ),
            ),
            Text(
              text3,
              style: GoogleFonts.inter(
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.w600,
                  color: detailsColor),
            ),
          ],
        ),
      ),
    );
  }
}
