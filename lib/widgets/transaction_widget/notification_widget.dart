import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(
      {super.key,
      required this.img,
      required this.title,
      required this.subTitle,
      required this.dateText});
  final String img, title, subTitle, dateText;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.only(right: Dimensions.defaultPaddingSize * 0.4),
        height: Dimensions.heightSize * 5,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: SvgPicture.asset(img),
            ),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: crossStart,
                children: [
                  addVerticalSpace(Dimensions.heightSize),
                  Row(
                    mainAxisAlignment: mainSpaceBet,
                    children: [
                      Text(
                        title,
                        style: CustomStyle.smallTextStyle,
                      ),
                      Text(
                        dateText,
                        style: CustomStyle.dateTextStyle,
                      ),
                    ],
                  ),
                  addVerticalSpace(Dimensions.widthSize),
                  Text(
                    subTitle,
                    style: GoogleFonts.inter(
                      color: CustomColor.secondaryTextColor,
                      fontSize: Dimensions.smallestTextSize,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
