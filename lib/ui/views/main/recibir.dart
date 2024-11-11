import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:trip_tour_coin/shared/BottomNavigation.dart';

import '../../../class/language_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';
import '../../layouts/core_layaout.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class RecibirPage extends StatefulWidget {
  const RecibirPage({Key? key}) : super(key: key);

  @override
  State<RecibirPage> createState() => _RecibirPageState();
}

class _RecibirPageState extends State<RecibirPage> {
  //mobile scanner
  String? _scanBarcode = 'Unknown';
  MobileScannerController cameraController = MobileScannerController();



  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor:Colors.black,
        title: Text(translation(context).receive_text + ' Saldo', style: TextStyle(color: Colors.white)),
        //icon to go back
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            NavigationService.replaceRemoveTo(
                Flurorouter.myWalletRoute);
          },
        ),

      ),
        bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
          if (idx == uiProvider.selectedMainMenu) return;
          uiProvider.selectedMainMenu = idx;
          uiProvider.appBarReset();
          NavigationService.navigateTo( uiProvider.pages[uiProvider.selectedMainMenu]);
        }),
        body: Container(
      color: backgroundcolor  ,
      child: ListView(children: [
        SizedBox(height:30),
        Container(
                child: Center(
                  child: Text(translation(context).ttc_address_text,style: TextStyle(color: goldcolor,fontSize: 30,fontWeight: FontWeight.bold),)
                ),

        )
        ,
        SizedBox(height:30),
        Container(

          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Center(
            child: QrImage(
              backgroundColor: white,
              data: authProv.user!.address,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Center(
            child: Text(authProv.user!.address,style: TextStyle(color: white,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
          ),
        ),

        SizedBox(height:30),
        //add two inline buttons copy and share
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {

                  Clipboard.setData(ClipboardData(text: authProv.user!.address));
                  //show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(translation(context).copied_clipboard_text)));
                },
                child: Text(translation(context).copy_text, style: TextStyle(color: white,fontSize: 18,fontWeight: FontWeight.bold),),
                //make the button borders gold
                style: ElevatedButton.styleFrom(
                  foregroundColor: goldcolor, backgroundColor: backgroundcolor, padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  side: BorderSide(color: goldcolor, width: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),

            ],
          ),
        ),



      ],)

    )

    );
  }
}
