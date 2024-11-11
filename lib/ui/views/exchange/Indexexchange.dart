import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/models/CasaDeCambio.dart';
import 'package:trip_tour_coin/router/router.dart';

import '../../../class/language_constants.dart';
import '../../../api/HttpApi.dart';
import '../../../models/Exchange.dart';
import '../../../models/http/error_http.dart';
import '../../../providers/ui_provider.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';
import '../../../widgets/button_widget/primary_button.dart';


class ExchangeIndex extends StatefulWidget {
  const ExchangeIndex({Key? key}) : super(key: key);

  @override
  State<ExchangeIndex> createState() => _ExchangeIndexState();
}

class _ExchangeIndexState extends State<ExchangeIndex> {

//list of Exchange
  List<Exchange> cambios= [];
  //list of Casa de Cambio

  @override
  void initState() {


    //await for get offers
    HttpApi.httpGet('/exchanges').then((value) {
      //balance = value['balance'].;
      //type 'int' is not a subtype of type 'double'
      print('imprime');
      var data = value['data'];

      List<Exchange> exchanges= [];


      print(data.length);
      print(data);
      print('alv');

      //fill houses list

      //fill exchanges list
      for(var i = 0; i < data.length; i++){
        var exchange = Exchange.fromJson(data[i]);
        exchanges.add(exchange);
      }

      setState(() {

        cambios = exchanges;

      });




      //PR
      print('entra aqui');
    }).catchError((error) {
      //if error is ErrorHttp
  print(error);
      if (error is ErrorHttp) {
        print(error.data);
        //if error is 401
        //if error data message is unauthorized
        if (error.data['message'] == 'unauthorized') {
          //show dialog
          print('unauthorized + redireccionar a login');
          //redirect to login using flurorouter
          Flurorouter.router.navigateTo(context, '/login',
              transition: TransitionType.fadeIn);

        }
      }
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(translation(context).add_exchange_currency_exchange_text),
        //icon to go back
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              NavigationService.replaceRemoveTo(
                  Flurorouter.homeRoute)
            }),
      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo(
            uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      body: Container(
        height: double.infinity,
        color : backgroundcolor,
        //add a listview
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Container(
            ///horizontal margin 5
            ///vertical margin 10
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child:Text(translation(context).exchange_history, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: goldcolor)),
            ),

            SizedBox(height: 20),
            //place a golden button to go to the exchange at the bottom of the list
            //SizedBox(height: 20),
            //list of exchanges
      Container(
        ///horizontal margin 5
        ///vertical margin 10
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child:
            //elevated golden button with icon plus
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: goldcolor, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // <-- Radius
            ),
          ),
          onPressed: () {
            //go to exchange create
            NavigationService.replaceRemoveTo(
                Flurorouter.exchangeAddRoute);
          },
          icon: Icon(Icons.add, size: 25),
          label: Text(translation(context).make_exchange_text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ),    //list of exchangesq
            SizedBox(height: 20),
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: cambios.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children:[
                        Image.asset('assets/logo-ttc.png', width: 20, height: 20,),
                        SizedBox(width: 10),
                        Text(translation(context).amount_text + ': '+cambios[index].amount.toString(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: white)),
                        SizedBox(width: 5),
                        Text('TTC', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: white)),
                      //ttc     SizedBox(width: 10),png
                        SizedBox(width: 10),
                      ]),
                      Text(translation(context).currency_exchange_text + ': '+cambios[index].house!.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:white)),
                      //direccion
                      Text(translation(context).address_text + ': '+cambios[index].house!.address, style: TextStyle(fontSize: 16, color: white)),
                     //phone text with copy icon
                      Row(
                        children: [
                          Text(translation(context).phone_text + ': '+cambios[index].house!.phone, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: white)),
                          SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.copy, color: Colors.white),
                            onPressed: () {
                              //copy phone to clipboard
                              Clipboard.setData(new ClipboardData(text: cambios[index].house!.phone));
                              //show toast
                              //show snackbar
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(translation(context).phone_copied),
                                duration: Duration(seconds: 2),
                              ));
                            },
                          ),
                        ],
                      ),
                      //status
                     SizedBox(height: 10),
                      Row(
                        children: [
                        //badge with status pending=yellow, completed=green, rejected=red
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: cambios[index].status == 'pending' ? lightgold : cambios[index].status == 'completed' ? Colors.greenAccent : Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          //text pendiente, completado y rechazado en espanol
                          child: Text(cambios[index].status == 'pending' ? translation(context).pending_text : cambios[index].status == 'completed' ? translation(context).completed_text : translation(context).declined_text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),

                        ),
                        ],
                      )

                    ],
                  ),
                );
              },
            ),


            SizedBox(height: 20),

              //get http://

          ],
        ),

      ),
    );
  }
}
