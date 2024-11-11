import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/CasaDeCambio.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';
import 'EditCasaDeCambio.dart';

class CasasDeCambio extends StatefulWidget {
  const CasasDeCambio({Key? key}) : super(key: key);

  @override
  State<CasasDeCambio> createState() => _CasasDeCambioState();
}

class _CasasDeCambioState extends State<CasasDeCambio> {
  bool isloading = true;
  List<CasaDeCambio> casas = [];
  @override
  void initState() {
    //initializeDateFormatting('es_ES');

    HttpApi.httpGet('/casa_de_cambios').then((value) {

      //convert value to json
      var data=   value['data'];
      for (var i = 0; i < data.length; i++) {
        print(data[i]);
        CasaDeCambio casa = CasaDeCambio.fromJson(data[i]);
        casas.add(casa);//
      }
      setState(() {
        isloading = false;
      });

    }).catchError((error) {
      print(error);
      print(error.data);
    });
  }


  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(translation(context).list_currency_exchange_text),
          //icon to go back
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => {
                    NavigationService.replaceRemoveTo(
                        Flurorouter.administracionRoute)
                  }),
        ),
        bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
          if (idx == uiProvider.selectedMainMenu) return;
          uiProvider.selectedMainMenu = idx;
          uiProvider.appBarReset();
          NavigationService.navigateTo(
              uiProvider.pages[uiProvider.selectedMainMenu]);
        }),
        //add floating action button
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            NavigationService.navigateTo(Flurorouter.casadecambioaddRoute)
          },
          child: Icon(Icons.add, color: Colors.black,),
          backgroundColor: goldcolor,
        ),
        body: Container(
          color: backgroundcolor,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [

              //list of cards
              ...casas.map((casa) {
                return Card(
                  color: Colors.black,
               //return listile black
                  child: ListTile(
                    leading: Image.network('http://3.16.217.214/'+casa.image),

                    title: Text(casa.name,
                        style: TextStyle(color: Colors.white)),
                    subtitle: Column(
crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                      Text(casa.address, style: TextStyle(color: Colors.grey)),

                      ],
                    ),

                    trailing: Icon(Icons.more_vert,color: Colors.white,),
                    onTap: () => {
                      //push screen to edit offer
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  EditCasaDeCambio(id: casa.id )))

                    },
                  ),
                );
              }).toList()
            ],
          ),
        ));
  }
}
