import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';


class StakingEarnView extends StatefulWidget {
  const StakingEarnView({Key? key}) : super(key: key);

  @override
  State<StakingEarnView> createState() => _StakingEarnViewState();
}

class _StakingEarnViewState extends State<StakingEarnView> {
  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context, listen: false);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(translation(context).confirmation_text),
        //icon to go back
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => NavigationService.replaceRemoveTo(Flurorouter.stakingRoute)
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo( uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      body: Container(
        color: backgroundcolor,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            //title historial de staking
            SizedBox(height: 5),
            Image.asset('assets/logo-ttc.png',width: 100,height: 100),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(translation(context).success_text, style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold )),
              ],
            ),


            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(translation(context).we_registered_staking_request_text, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),

              ],
            ),
            SizedBox(height: 60),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        NavigationService.replaceTo( Flurorouter.homeRoute);
                      },
                      child: Text(translation(context).continue_text, style: TextStyle( fontSize: 16,  color: Colors.black, fontWeight: FontWeight.bold) ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: goldcolor,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        disabledBackgroundColor: Colors.grey,
                      )
                  ),
                ),
              ],
            )


          ],
        ),
      ),
    );
  }

  Widget dropButt(){
    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
    ];
    String? selectedValue;


    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          translation(context).select_item_text,
          style: TextStyle( fontSize: 14, color: Colors.white, ),
        ),
        items: items .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text( item, style: const TextStyle( fontSize: 14,  ) ),
        )) .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 40, width: 140,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration( color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),

        ),
        menuItemStyleData: const MenuItemStyleData( height: 40 ),
      ),
    );
  }
  
}
