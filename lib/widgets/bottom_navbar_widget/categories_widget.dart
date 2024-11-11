import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/assets.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key, required this.img, required this.text});
  final String img, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        addVerticalSpace(Dimensions.heightSize * 0.4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              fontSize: Dimensions.smallestTextSize,
              fontWeight: FontWeight.w700,
              color: CustomColor.whiteColor),
        ),
      ],
    );
  }
}
