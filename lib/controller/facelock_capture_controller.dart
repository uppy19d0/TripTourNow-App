import 'package:get/get.dart';

import '../router/router.dart';
import '../services/navigation_service.dart';

class FacelockColotroller extends GetxController {
  void onPressedSkipNow() {
    //Get.toNamed(Routes.signInOptionsScreen);
  }

  void onPressedCapture() {
    //Get.toNamed(Routes.facelockEnterScreen);
  }

  void onPressedconfirm() {
    //Get.toNamed(Routes.waitForApprovalScreen);
    NavigationService.navigateTo(Flurorouter.waitForApprovalRoute);
  }
}
