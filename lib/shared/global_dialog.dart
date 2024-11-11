import 'package:flutter/material.dart';
import 'package:trip_tour_coin/theme.dart';

import '../class/language_constants.dart';
import '../services/navigation_service.dart';

class GlobalTools {
  void showMsgDialog({String title = "", String content = ""}) {
    showDialog(
        context: NavigationService.navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(

            title: Text(title, style: Theme.of(context).textTheme.titleLarge),
            content:
                Text(content, style: Theme.of(context).textTheme.titleMedium),
          );
        });
  }

  //closedialog
  void closeDialog() {
    //
    //Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
    //do the pop but only if the dialog is open
    if (Navigator.canPop(NavigationService.navigatorKey.currentContext!)) {
      Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
    }
  }

  showSnackBar({required String message, Color color = Colors.red}) {
    var snack = SnackBar(
      duration: Duration(seconds: 2),
      content: Container(
        height: 50,
        alignment: Alignment.center,
        child: Text(message,
            style: Theme.of(NavigationService.navigatorKey.currentContext!)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
            textAlign: TextAlign.center),
      ),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(snack);
  }

  //close snackbar
  void closeSnackBar() {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .hideCurrentSnackBar();
  }

  Future<void> showConfirmation(
      {String title = "", String content = ""}) async {
    return showDialog<void>(
      context: NavigationService.navigatorKey.currentContext!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: title.isNotEmpty ? Text(title) : null,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(translation(context).yes),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void showWaitDialog(
      {String title = "",
      String content = "",
      String waitText = "Checking..."}) {
    showDialog(
        context: NavigationService.navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,

            title: title.isNotEmpty ? Text(title) : null,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (content.isNotEmpty) ...[
                  Text(content, style: Theme.of(context).textTheme.labelMedium),
                  SizedBox(height: 20),
                ],
                CircularProgressIndicator(color: goldcolor,),
                SizedBox(height: 20),
                Text(waitText, style: TextStyle(color: Colors.white),)
              ],
            ),
          );
        });
  }

  void showErrorDialog(
      {required errorText,
      required buttonText,
      required Null Function() buttonCallback}) {}
}
