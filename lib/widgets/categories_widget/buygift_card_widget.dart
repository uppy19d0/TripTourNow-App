import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/assets.dart';
import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';
import '../../utils/strings.dart';

class BuyGiftCardWidget extends StatelessWidget {
  const BuyGiftCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.defaultPaddingSize,
        left: Dimensions.defaultPaddingSize * 0.6,
        right: Dimensions.defaultPaddingSize * 0.6,
      ),
      child: Column(
        children: [
          Card(
            elevation: 5,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.radius * 1.5,
              ),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
                image: const DecorationImage(
                    image: AssetImage(
                      Assets.buyCard,
                    ),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  _blackCardWidget(context),
                  _textWidget(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _blackCardWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      margin: EdgeInsets.only(
        top: Dimensions.marginSize * 0.8,
        left: Dimensions.marginSize * 0.6,
        right: Dimensions.marginSize * 0.6,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.defaultPaddingSize * 0.7,
        vertical: Dimensions.defaultPaddingSize * 0.6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius * 1.3),
        color: CustomColor.blackColor,
      ),
      child: Column(
        mainAxisAlignment: mainSpaceBet,
        children: [
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              Text(
                Strings.googlePlay,
                style: CustomStyle.addUsdTextStyle,
              ),
              SvgPicture.asset(Assets.playstore)
            ],
          ),
          Text(
            "9864 1326 7135 3126",
            style: TextStyle(
              fontFamily: "AgencyFB",
              fontSize: Dimensions.subTitleText,
              fontWeight: FontWeight.w700,
              color: CustomColor.whiteColor.withOpacity(0.6),
            ),
          ),
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              Column(
                mainAxisAlignment: mainCenter,
                children: [
                  Text(
                    Strings.nineElevent,
                    style: CustomStyle.addUsdTextStyle,
                  ),
                  Text(
                    Strings.expiryDate,
                    style: CustomStyle.expairywhiteTextStyle,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: mainCenter,
                children: [
                  Text(
                    Strings.nineSix,
                    style: CustomStyle.addUsdTextStyle,
                  ),
                  Text(
                    Strings.cvc,
                    style: CustomStyle.expairywhiteTextStyle,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  _textWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.defaultPaddingSize * 0.1,
        horizontal: Dimensions.marginSize * 0.7,
      ),
      child: Column(
        crossAxisAlignment: crossStart,
        mainAxisAlignment: mainSpaceBet,
        children: [
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              Text(
                Strings.googlePlayGiftCard,
                style: CustomStyle.percentTextStyle,
              ),
              Container(
                alignment: Alignment.center,
                height: Dimensions.heightSize * 1.8,
                width: Dimensions.widthSize * 7,
                decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                ),
                child: Text(
                  Strings.moreInfo,
                  style: CustomStyle.moreInfoTextStyle,
                ),
              )
            ],
          ),
          Text(
            Strings.category,
            style: CustomStyle.mediumColorTextStyle,
          ),
          addVerticalSpace(Dimensions.heightSize),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultPaddingSize * 0.2),
                  height: Dimensions.heightSize * 2,
                  width: Dimensions.widthSize * 14,
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                  ),
                  child: Row(
                    children: [
                      Text(
                        Strings.available,
                        style: CustomStyle.availableTextStyle,
                      ),
                      addHorizontalSpace(Dimensions.widthSize * 0.8),
                      Text(
                        Strings.five,
                        style: CustomStyle.fiveTextStyle,
                      ),
                      Text(
                        Strings.cards,
                        style: CustomStyle.cardsTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: crossEnd,
                  children: [
                    Text(
                      Strings.uSD100,
                      style: CustomStyle.percentTextStyle,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.defaultPaddingSize * 2.4),
                      child: Row(
                        children: [
                          Text(
                            Strings.price,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.inter(
                              fontSize: Dimensions.smallTextSize * 1.1,
                              fontWeight: FontWeight.w600,
                              color: CustomColor.primaryColor,
                            ),
                          ),
                          Text(
                            Strings.cards,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.inter(
                              fontSize: Dimensions.smallestTextSize * 1.1,
                              fontWeight: FontWeight.w600,
                              color: CustomColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
