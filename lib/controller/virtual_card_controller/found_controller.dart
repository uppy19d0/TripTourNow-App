import 'package:get/get.dart';

class FoundController extends GetxController {
  RxString selectCurrency = "USD".obs;

  List<String> currencyList = ["USD", "AUD"];

  void onPresedbackToHome() {
    //Get.toNamed(Routes.bottomNavBarScreen);
  }
}
