import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_tour_coin/services/navigation_service.dart';
import 'package:trip_tour_coin/theme.dart';
import '../../../router/router.dart';
import '../../../utils/custom_style.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/size.dart';
import '../../../utils/strings.dart';
import '../../../widgets/button_widget/primary_button.dart';
import '../../../class/language_constants.dart';


class WaitForApprovalScreen extends StatelessWidget {
  WaitForApprovalScreen({Key? key}) : super(key: key);
  final congratulationData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return
       Container(color:backgroundcolor, child: Column(
      mainAxisAlignment: mainCenter,
      children: [
        _congratulationImg(context),
        _titleWidget(context),
        _okayButtonWidget(context)
      ],
    ));
  }

  _congratulationImg(BuildContext context) {
    return Image.asset(
      'assets/Clipart/warn.png',
      height: MediaQuery.of(context).size.height * 0.19,
      width: MediaQuery.of(context).size.height * 0.19,
    );
  }

  _titleWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.marginSize * 1.7),
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.defaultPaddingSize * 0.6),
      child: Column(
        children: [
          Text(
            translation(context).waiting_for_approval,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: goldcolor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            )
          ),
          addVerticalSpace(Dimensions.heightSize * 0.5),
          Text(
            translation(context).your_account_being_reviewed,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            )
          ),
        ],
      ),
    );
  }

  _okayButtonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSize * 1.3,
      ),
      alignment: Alignment.centerRight,
      child: PrimaryButtonWidget(
        text: Strings.okay,
        onPressed: () {
          NavigationService.navigateTo( Flurorouter.myAccountRoute);
        },
      ),
    );
  }
}
