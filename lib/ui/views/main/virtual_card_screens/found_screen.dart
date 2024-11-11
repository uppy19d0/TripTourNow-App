import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../controller/virtual_card_controller/found_controller.dart';
import '../../../../generated/assets.dart';
import '../../../../utils/custom_color.dart';
import '../../../../utils/custom_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/size.dart';
import '../../../../utils/strings.dart';
import '../../../../widgets/button_widget/primary_button.dart';
import '../../../../widgets/others/dashboard_appbar.dart';


class FoundScreen extends StatelessWidget {
  FoundScreen({super.key});
  final controller = Get.put(FoundController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Stack(
      children: [



      ],
    );
  }

  _appbarWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            CustomColor.whiteColor.withOpacity(0.0),
            CustomColor.whiteColor.withOpacity(0.1)
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      child: DashboardAppBar(
          elevation: 0,
          centerTitle: false,
          ledeaing: Container(
            padding:
                EdgeInsets.symmetric(vertical: Dimensions.heightSize),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },

            ),
          ),
          title: Strings.found),
    );
  }

  _amountWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.defaultPaddingSize * 3),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          Text(
            Strings.uSD100,
            style: CustomStyle.addAmountTexStyle,
          ),
          addVerticalSpace(Dimensions.heightSize * 0.4),
          Text(
            Strings.enterAmount,
            style: CustomStyle.enterAmountTextStyle,
          ),
        ],
      ),
    );
  }

  _dropDownWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Dimensions.defaultPaddingSize * 1.7,
      ),
      height: Dimensions.heightSize * 3.7,
      width: Dimensions.widthSize * 11,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
        color: CustomColor.whiteColor.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: mainCenter,
        children: [
          Text(
            controller.selectCurrency.value,
            style: CustomStyle.whiteColorTextStyle,
          ),
          addHorizontalSpace(0),
          DropdownButton(
            alignment: Alignment.topLeft,
            iconEnabledColor: CustomColor.whiteColor,
            iconSize: Dimensions.heightSize * 2,
            dropdownColor: CustomColor.whiteColor,
            underline: Container(height: 0),
            items:
                controller.currencyList.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value.toString(),
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    color: controller.selectCurrency.value == value
                        ? CustomColor.primaryColor
                        : CustomColor.primaryTextColor,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              controller.selectCurrency.value = value!;
            },
          ),
        ],
      ),
    );
  }

  _numbersWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "1",
              style: CustomStyle.addAmountTexStyle,
            ),
            Text(
              "2",
              style: CustomStyle.addAmountTexStyle,
            ),
            Text(
              "3",
              style: CustomStyle.addAmountTexStyle,
            ),
          ],
        ),
        addVerticalSpace(Dimensions.heightSize * 1.7),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "4",
              style: CustomStyle.addAmountTexStyle,
            ),
            Text(
              "5",
              style: CustomStyle.addAmountTexStyle,
            ),
            Text(
              "6",
              style: CustomStyle.addAmountTexStyle,
            ),
          ],
        ),
        addVerticalSpace(Dimensions.heightSize * 1.8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "7",
              style: CustomStyle.addAmountTexStyle,
            ),
            Text(
              "8",
              style: CustomStyle.addAmountTexStyle,
            ),
            Text(
              "9",
              style: CustomStyle.addAmountTexStyle,
            ),
          ],
        ),
        addVerticalSpace(Dimensions.heightSize * 1.8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "+",
              style: CustomStyle.addAmountTexStyle,
            ),
            Text(
              "0",
              style: CustomStyle.addAmountTexStyle,
            ),
            Text(
              "<",
              style: CustomStyle.addAmountTexStyle,
            ),
          ],
        ),
      ],
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: Dimensions.defaultPaddingSize * 1.2,
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
        bottom: Dimensions.marginSize,
      ),
      height: Dimensions.heightSize * 8,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              CustomColor.whiteColor.withOpacity(0.1),
              CustomColor.whiteColor.withOpacity(0.1)
            ],
            tileMode: TileMode.mirror,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius * 2),
            topRight: Radius.circular(Dimensions.radius * 2),
          )),
      child: GestureDetector(
        onTap: () {
          showBottomSheet(context);
        },
        child: Container(
          height: Dimensions.heightSize * 4.2,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
              color: CustomColor.primaryColor),
          child: Center(
            child: Row(
              mainAxisAlignment: mainCenter,
              children: [

                addHorizontalSpace(
                  Dimensions.widthSize * 0.7,
                ),
                Text(
                  Strings.addFund,
                  style: GoogleFonts.inter(
                    fontSize: Dimensions.extraLargeTextSize,
                    color: CustomColor.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showBottomSheet(BuildContext context) => showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 1.5),
          topRight: Radius.circular(Dimensions.radius * 1.5),
        )),
        elevation: 0,
        backgroundColor: CustomColor.whiteColor,
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 1.5),
              topRight: Radius.circular(Dimensions.radius * 1.5),
            )),
            padding: EdgeInsets.all(Dimensions.marginSize * 0.9),
            height: MediaQuery.of(context).size.height * 0.42,
            child: Column(
              mainAxisAlignment: mainCenter,
              children: [

                addVerticalSpace(Dimensions.heightSize),
                Text(
                  Strings.addFundSucces,
                  style: CustomStyle.boldTitleTextStyle,
                ),
                Text(
                  Strings.yourMoneyAddedSucces,
                  textAlign: TextAlign.center,
                  style: CustomStyle.defaultSubTitleTextStyle,
                ),
                addVerticalSpace(Dimensions.heightSize * 2),
                PrimaryButtonWidget(
                    text: Strings.backtoHome,
                    onPressed: () {
                      controller.onPresedbackToHome();
                    }),
              ],
            ),
          );
        },
      );
}
