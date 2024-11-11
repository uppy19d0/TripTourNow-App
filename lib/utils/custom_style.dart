import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'custom_color.dart';
import 'dimensions.dart';

class CustomStyle {
  //auth screens
  static var welcomeTOTextTitle = GoogleFonts.inter(
    color: CustomColor.thirdTextColor,
    fontSize: Dimensions.onboardsubTitle,
    fontWeight: FontWeight.w500,
  );

  static var defaultTitleTextTitle = GoogleFonts.inter(
    color: CustomColor.textButtonColor,
    fontSize: Dimensions.largeTextSize,
    fontWeight: FontWeight.w600,
  );

  static var hintTextStyle = GoogleFonts.inter(
    color: CustomColor.borderColor,
    fontSize: Dimensions.defaultTextSize,
    fontWeight: FontWeight.w600,
  );
  static var settingTextStyle = GoogleFonts.inter(
    color: CustomColor.thirdTextColor,
    fontSize: Dimensions.largeTextSize,
    fontWeight: FontWeight.w600,
  );

  static var defaultSubTitleTextStyle = GoogleFonts.inter(
    color: CustomColor.thirdTextColor,
    fontSize: Dimensions.mediumTextSize,
    fontWeight: FontWeight.w500,
  );

  static var borderColorText = GoogleFonts.inter(
    color: CustomColor.borderColor,
    fontSize: Dimensions.defaultTextSize,
    fontWeight: FontWeight.w600,
  );
  static var smallestTExtStyle = GoogleFonts.inter(
    color: CustomColor.secondaryTextColor,
    fontSize: Dimensions.smallestTextSize * 0.9,
    fontWeight: FontWeight.w500,
  );
  //white color text style
  static var expairywhiteTextStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor.withOpacity(0.6),
    fontSize: Dimensions.smallestTextSize,
    fontWeight: FontWeight.w500,
  );
  static var enterAmountTextStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor.withOpacity(0.6),
    fontSize: Dimensions.largeTextSize,
    fontWeight: FontWeight.w500,
  );
  static var expiryTextStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor.withOpacity(0.6),
    fontSize: Dimensions.mediumTextSize,
    fontWeight: FontWeight.w600,
  );
  static var whiteColorTextStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.mediumTextSize,
    fontWeight: FontWeight.w600,
  );

  static var qrAddressTextStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.smallestTextSize * 1.06,
    fontWeight: FontWeight.w600,
  );

  static var transactionTextStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor.withOpacity(0.8),
    fontSize: Dimensions.defaultTextSize,
    fontWeight: FontWeight.w600,
  );
  static var addUsdTextStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.defaultTextSize,
    fontWeight: FontWeight.w600,
  );
  static var costTextStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor.withOpacity(0.8),
    fontSize: Dimensions.smallTextSize,
    fontWeight: FontWeight.w600,
  );
  static var amountTextStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.mediumTextSize,
    fontWeight: FontWeight.w700,
  );
  static var moreInfoTextStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.smallestTextSize,
    fontWeight: FontWeight.w700,
  );
  static var recipientInformationTexStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.largeTextSize,
    fontWeight: FontWeight.w700,
  );
  static var addAmountTexStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.subTitleText,
    fontWeight: FontWeight.w700,
  );
  static var currentAmountTexStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.onboardsubTitle,
    fontWeight: FontWeight.w700,
  );

  static var nameTexStyle = GoogleFonts.inter(
    color: CustomColor.whiteColor,
    fontSize: Dimensions.mediumTextSize * 1.06,
    fontWeight: FontWeight.w700,
  );
  //primary color text style
  static var transferFeeTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor.withOpacity(0.8),
    fontSize: Dimensions.smallTextSize,
    fontWeight: FontWeight.w500,
  );
  static var quantityPriceTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.mediumTextSize,
    fontWeight: FontWeight.w500,
  );
  static var priColorTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.mediumTextSize,
    fontWeight: FontWeight.w500,
  );
  static var inputTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor.withOpacity(0.6),
    fontSize: Dimensions.defaultTextSize,
    fontWeight: FontWeight.w600,
  );
  static var labelTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor.withOpacity(0.6),
    fontSize: Dimensions.defaultTextSize,
    fontWeight: FontWeight.w600,
  );
  static var mediumColorTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.mediumTextSize,
    fontWeight: FontWeight.w600,
  );

  static var amountColorTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor.withOpacity(0.8),
    fontSize: Dimensions.smallTextSize,
    fontWeight: FontWeight.w600,
  );
  static var detailsColorTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.smallTextSize,
    fontWeight: FontWeight.w600,
  );
  static var profileTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.largeTextSize,
    fontWeight: FontWeight.w600,
  );

  static var percentTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.largeTextSize,
    fontWeight: FontWeight.w700,
  );
  static var recipientTilteTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.defaultTextSize,
    fontWeight: FontWeight.w700,
  );
  static var availableTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.smallestTextSize * 1.1,
    fontWeight: FontWeight.w700,
  );
  static var fiveTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.mediumTextSize * 1.1,
    fontWeight: FontWeight.w700,
  );
  static var cardsTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryColor,
    fontSize: Dimensions.smallestTextSize,
    fontWeight: FontWeight.w700,
  );

//dialoge

  static var forgotSubTitleTextStyle = GoogleFonts.inter(
    color: CustomColor.thirdTextColor,
    fontSize: Dimensions.smallTextSize,
    fontWeight: FontWeight.w500,
  );
  //notification

  static var dateTextStyle = GoogleFonts.inter(
    color: CustomColor.secondaryTextColor,
    fontSize: Dimensions.smallestTextSize,
    fontWeight: FontWeight.w500,
  );
  static var feeTextStyle = GoogleFonts.inter(
    color: CustomColor.secondaryTextColor,
    fontSize: Dimensions.smallTextSize,
    fontWeight: FontWeight.w500,
  );
  static var billTypeTextStyle = GoogleFonts.inter(
    color: CustomColor.thirdTextColor,
    fontSize: Dimensions.smallestTextSize,
    fontWeight: FontWeight.w500,
  );
  //preview
  static var amountTilteText = GoogleFonts.inter(
    color: CustomColor.secondaryTextColor,
    fontSize: Dimensions.mediumTextSize,
    fontWeight: FontWeight.w600,
  );
  //black text style
  static var welcmeTitleTextTitle = GoogleFonts.inter(
    color: CustomColor.primaryTextColor,
    fontSize: Dimensions.smallTextSize,
    fontWeight: FontWeight.w500,
  );
  static var resendTextStyle = GoogleFonts.inter(
    color: CustomColor.textButtonColor,
    fontSize: Dimensions.smallTextSize,
    fontWeight: FontWeight.w600,
  );
  static var forgotTitleTextStyle = GoogleFonts.inter(
    color: CustomColor.textButtonColor,
    fontSize: Dimensions.largeTextSize,
    fontWeight: FontWeight.w600,
  );
  static var recentTransactionTextStyle = GoogleFonts.inter(
    color: CustomColor.blackColor,
    fontSize: Dimensions.extraLargeTextSize,
    fontWeight: FontWeight.w700,
  );
  static var smallTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryTextColor,
    fontSize: Dimensions.smallTextSize,
    fontWeight: FontWeight.w600,
  );
  static var extraLargeBlackTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryTextColor,
    fontSize: Dimensions.extraLargeTextSize,
    fontWeight: FontWeight.w600,
  );
  static var boldTitleTextStyle = GoogleFonts.inter(
    color: CustomColor.primaryTextColor,
    fontSize: Dimensions.onboardsubTitle,
    fontWeight: FontWeight.w700,
  );
  static var welcomeTitleTextTitle = GoogleFonts.inter(
    color: CustomColor.primaryTextColor,
    fontSize: Dimensions.titleText,
    fontWeight: FontWeight.w700,
  );
}
