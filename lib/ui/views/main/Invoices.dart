import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({Key? key}) : super(key: key);

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Facturas'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () =>
                NavigationService.replaceRemoveTo(Flurorouter.backofficeRoute),
          )),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo( uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: backgroundcolor,
        child: Container(
          color: backgroundcolor,
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 40),
              children: [
                SizedBox(height: 20),
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: ListTile(
                    trailing: Text("PENDIENTE",
                        style: TextStyle(color: goldcolor, fontSize: 14)),
                    title: Container(
                      child: Row(children: [
                        Image.asset(
                          'assets/logo-ttc.png',
                          width: 15,
                          height: 20,
                        ),
                        SizedBox(width: 5),
                        Text("500 TTC",
                            style: TextStyle(color: white, fontSize: 16)),
                      ]),
                    ),
                    subtitle: Text("Compra de ropa en el centro comercial",
                        style: TextStyle(color: white, fontSize: 12)),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: ListTile(
                    trailing: Text("PAGADA",
                        style: TextStyle(color: Colors.green, fontSize: 14)),
                    title: Container(
                      child: Row(children: [
                        Image.asset(
                          'assets/logo-ttc.png',
                          width: 15,
                          height: 20,
                        ),
                        SizedBox(width: 5),
                        Text("1000 TTC",
                            style: TextStyle(color: white, fontSize: 16)),
                      ]),
                    ),
                    subtitle: Text("Cena en restaurante Maralia en capcana",
                        style: TextStyle(color: white, fontSize: 12)),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: ListTile(
                    trailing: Text("CANCELADA",
                        style: TextStyle(color: Colors.red, fontSize: 14)),
                    title: Container(
                      child: Row(children: [
                        Image.asset(
                          'assets/logo-ttc.png',
                          width: 15,
                          height: 20,
                        ),
                        SizedBox(width: 5),
                        Text("310 TTC",
                            style: TextStyle(color: white, fontSize: 16)),
                      ]),
                    ),
                    subtitle: Text("Compra en el supermecado",
                        style: TextStyle(color: white, fontSize: 12)),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
