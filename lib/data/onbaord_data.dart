import 'package:flutter/material.dart';

import '../generated/assets.dart';
import '../utils/custom_color.dart';
import '../utils/strings.dart';
import '../widgets/onboard_widget/onboard_widget.dart';

List<OnboardWidget> onboardData = [
  OnboardWidget(
    bgColor: CustomColor.whiteColor,
    img: Assets.tripTourCoinAssetsUser, // Assets.onboard1,
    text1: Strings.easyFast,
    text2: Strings.trusted,
    text3: Strings.userTransferMoney,
  ),
  const OnboardWidget(
    bgColor: CustomColor.primaryColor,
    img: Assets.tripTourCoinAssetsUser, // Assets.onboard2,
    text1: Strings.qrTransaction,
    text2: Strings.system,
    text3: Strings.userCanTransgerMoney,
  ),
  const OnboardWidget(
    bgColor: Color(0xFF5200FF),
    img: Assets.tripTourCoinAssetsUser, // Assets.onboard3,
    text1: Strings.biometricFacelock,
    text2: Strings.available,
    text3: Strings.useSecureInstant,
  ),
];

  // List<ItemData> data = [
  //   ItemData(Colors.blue, "assets/1.png", "Hi", "It's Me", "Sahdeep"),
  //   ItemData(Colors.deepPurpleAccent, "assets/1.png", "Take a", "Look At",
  //       "Liquid Swipe"),
  //   ItemData(Colors.green, "assets/1.png", "Liked?", "Fork!", "Give Star!"),
  //   ItemData(Colors.yellow, "assets/1.png", "Can be", "Used for",
  //       "Onboarding design"),
  //   ItemData(Colors.red, "assets/1.png", "Do", "try it", "Thank you"),
  // ];