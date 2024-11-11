import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../class/language_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';

class Withdraw_Paypal_Success extends StatefulWidget {
  const Withdraw_Paypal_Success({Key? key}) : super(key: key);

  @override
  State<Withdraw_Paypal_Success> createState() =>
      _Withdraw_Paypal_SuccessState();
}

class _Withdraw_Paypal_SuccessState extends State<Withdraw_Paypal_Success> {
  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Retiro a monederos Cripto',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w100),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
            onPressed: () {
              NavigationService.replaceRemoveTo(Flurorouter.homeRoute);
            },
          ),
        ),
        bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
          if (idx == uiProvider.selectedMainMenu) return;
          uiProvider.selectedMainMenu = idx;
          uiProvider.appBarReset();
          NavigationService.navigateTo(
              uiProvider.pages[uiProvider.selectedMainMenu]);
        }),
        body: Container(
            width: double.infinity,
            color: backgroundcolor,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Column(children: [
              //icons.s
              Icon(
                Icons.check_circle,
                color: goldcolor,
                size: 100,
              ),

              SizedBox(
                height: 30,
              ),
              Text(
                translation(context).withdrawal_request_generated_text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 20,
              ),
              Text(
                translation(context).withdrawPaypalSuccess_take_time_text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              //button
              SizedBox(
                height: 40,
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    //flurorouter
                    NavigationService.replaceRemoveTo(Flurorouter.homeRoute);
                  },
                  child: Text(
                    translation(context).back_main_menu_text,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40), backgroundColor: goldcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ])));
  }
}
