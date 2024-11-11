import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';

class Withdraw_Paypal_Confirm extends StatefulWidget {
  const Withdraw_Paypal_Confirm({Key? key}) : super(key: key);

  @override
  State<Withdraw_Paypal_Confirm> createState() => _Withdraw_Paypal_ConfirmState();
}

class _Withdraw_Paypal_ConfirmState extends State<Withdraw_Paypal_Confirm> {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(translation(context).confirm_withdrawal_text),
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
        child:Column(
            children:[
              //icons.s
              SizedBox(height: 30,),

              Icon(Icons.check_circle, color:goldcolor, size: 100,),

              SizedBox(height: 30,),
              Text(translation(context).withdrawal_request_generated_text, textAlign:TextAlign.center , style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),

              SizedBox(height: 20,),
              Text(translation(context).withdrawPaypalConfirm_take_time_text, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              //button
              SizedBox(height: 40,),
              Container(

                child: ElevatedButton(
                  onPressed: () {
                    //flurorouter
                    NavigationService.replaceRemoveTo(
                        Flurorouter.homeRoute);
                  },
                  child: Text(translation(context).back_main_menu_text, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40), backgroundColor: goldcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ]
        )
    )
    );
  }
}
