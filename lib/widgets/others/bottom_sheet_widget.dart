import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';

class CustomBottomShet extends StatelessWidget {
  const CustomBottomShet({super.key, required this.ontap, required this.text,  this.img});

 final VoidCallback ontap;
 final String text;
 final String? img;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 2),
          topRight: Radius.circular(Dimensions.radius * 2),
        ),
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: ontap,
        child: Container(
            padding: EdgeInsets.only(
              top: Dimensions.defaultPaddingSize * 1.2,
              left: Dimensions.marginSize,
              right: Dimensions.marginSize,
              bottom: Dimensions.marginSize,
            ),
            height: Dimensions.heightSize * 8,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: CustomColor.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius * 2),
                  topRight: Radius.circular(Dimensions.radius * 2),
                )),
            child: Container(
              height: Dimensions.heightSize * 4.2,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
                color: CustomColor.primaryColor,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: mainCenter,
                  children: [
                    SvgPicture.asset(
                      img!,
                      color: CustomColor.whiteColor,
                      height: Dimensions.heightSize * 1.5,
                      width: Dimensions.widthSize * 2,
                    ),
                    addHorizontalSpace(
                      Dimensions.widthSize * 0.7,
                    ),
                    Text(
                      text,
                      style: GoogleFonts.inter(
                        fontSize: Dimensions.extraLargeTextSize,
                        color: CustomColor.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
