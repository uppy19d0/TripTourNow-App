import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/assets.dart';
import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';

buildBottomNavigationMenu(context, bottomNavBarController) {
  return Container(
    height: Dimensions.heightSize * 4,
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
      color: CustomColor.primaryColor,
    ),
    child: BottomAppBar(
      color: CustomColor.primaryColor,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            bottomItemWidget(Assets.home2, bottomNavBarController, 0),
            addHorizontalSpace(Dimensions.widthSize * 11),
            bottomItemWidget(Assets.inbox, bottomNavBarController, 1),
          ],
        ),
      ),
    ),
  );
}

bottomItemWidget(var icon, bottomNavBarController, page) {
  return Expanded(
    child: InkWell(
      onTap: () {
        bottomNavBarController.selectedIndex.value = page;
      },
      child: SvgPicture.asset(
        icon,
        
        color: bottomNavBarController.selectedIndex.value == page
            ? CustomColor.whiteColor
            : CustomColor.whiteColor.withOpacity(0.5),
        height: 26,
      ),
    ),
  );
}
