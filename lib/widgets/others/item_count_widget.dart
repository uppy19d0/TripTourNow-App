import 'package:flutter/material.dart';
import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';

itemCountWidget(
    {required VoidCallback decrease,
    required VoidCallback increment,
    required int value}) {
  return SizedBox(
    height: Dimensions.heightSize * 3,
    width: Dimensions.widthSize * 14,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: decrease,
          child: Container(
           height: Dimensions.heightSize * 2.5,
            width: Dimensions.widthSize * 3.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Dimensions.radius * 0.34,
              ),
              color: CustomColor.primaryColor,
            ),
            child: const Icon(
              Icons.remove_rounded,
              color: CustomColor.whiteColor,
            ),
          ),
        ),
        addHorizontalSpace(
          Dimensions.widthSize,
        ),
        Container(
          alignment: Alignment.center,
          height: Dimensions.heightSize * 2.5,
          width: Dimensions.widthSize * 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimensions.radius * 0.5,
            ),
            border: Border.all(
              width: 2,
              color: CustomColor.primaryColor,
            ),
          ),
          child: Text(
            value.toString(),
            style: CustomStyle.percentTextStyle,
          ),
        ),
        addHorizontalSpace(
          Dimensions.widthSize,
        ),
        InkWell(
          onTap: increment,
          child: Container(
            height: Dimensions.heightSize * 2.5,
            width: Dimensions.widthSize * 3.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                Dimensions.radius * 0.34,
              ),
              color: CustomColor.primaryColor,
            ),
            child: const Icon(
              Icons.add_rounded,
              color: CustomColor.whiteColor,
            ),
          ),
        )
      ],
    ),
  );
}
