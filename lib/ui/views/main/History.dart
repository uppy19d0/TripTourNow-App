import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(translation(context).sales_history_text,),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => {
                    NavigationService.replaceRemoveTo(
                        Flurorouter.backofficeRoute)
                  }),
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                SizedBox(height: 20),
                //white text , aun no se ha registrado ninguna venta
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    translation(context).no_sales_recorded_yet_text,
                    style: TextStyle(color: white, fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                  ),
                ),
                /*Container(
                  color: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: ListTile(
                    title: Text("Se Ha comprado su oferta: Viaje a la luna",
                        style: TextStyle(color: goldcolor, fontSize: 14)),
                    subtitle:
                    Row(children:[Text("Fecha: 12/12/2021",style: TextStyle(color: white,fontSize: 12)),
                    Text("  Precio: 1000",style: TextStyle(color: white,fontSize: 12)),
                      SizedBox(width: 5),
                      Image.asset('assets/logo-ttc.png',width: 15,height: 15, ),
                    ]),
                    //trailing small button outlined golden
                    trailing: OutlinedButton(
                      onPressed: () {},
                      child: Text("Detalles",style: TextStyle(color: goldcolor)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: goldcolor),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4))),
                      ),
                    ),

                  ),

                ),
          */


              ]),
        ));
  }
}
