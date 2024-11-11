import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../theme.dart';
import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget(
      {super.key,
      required this.amount,
      required this.img,
      required this.title,
      required this.subTitle,
      required this.dateText});
  final String img, title, subTitle, dateText, amount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.defaultPaddingSize * 0.3),
      child: Container(

        margin: EdgeInsets.zero,
        child: Container(
          color: Colors.black ,
          padding: EdgeInsets.only(
              bottom: Dimensions.defaultPaddingSize * 0.1,
              right: Dimensions.defaultPaddingSize * 0.4),
          height: Dimensions.heightSize * 5,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: SvgPicture.asset(img, color: goldcolor ,),
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
                          style: TextStyle(
                            color: goldcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          dateText,
                          style: TextStyle(
                            color: white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(00),
                    Row(
                      mainAxisAlignment: mainSpaceBet,
                      children: [
                        Text(
                          subTitle,
                          style: TextStyle(
                            color: white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          amount,
                          style: TextStyle(
                            color: lightgold,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
