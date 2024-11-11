import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/models/reconciliation.dart';
import 'package:trip_tour_coin/theme.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/http/error_http.dart';
import '../../../providers/ui_provider.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';

//fontawesome icons
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//dateformat
import 'package:intl/intl.dart';

import '../../../shared/global_dialog.dart';

//required  parameter id of the reconciliation
class DetailConciliation extends StatefulWidget {
  final int id;

  const DetailConciliation({required this.id});

  @override
  _DetailConciliationState createState() => _DetailConciliationState();
}

class _DetailConciliationState extends State<DetailConciliation> {
  bool isloading = true;
  late Reconciliation conciliation;

  @override
  void initState() {
    HttpApi.httpGet('/reconciliation/' + widget.id.toString()).then((value) {
      print(value);
      //convert value to json
      var data = value['reconciliation'];
      print("aca");
      print(data);
      //create a list of reconciliations
      //loop through data

      setState(() {
        conciliation = Reconciliation.fromJson(data);
        isloading = false;
      });
    }).catchError((error) {
      print(error);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    var tasa = 0.017662881;

    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).transfer_details),
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo(
            uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      body: Container(
        color: backgroundcolor,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: (isloading == false)
            ? Column(
        //aling to left
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //CENTER icon Text file in gold
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          //icon
                          //fontawesome icon file import
                          FaIcon(
                            FontAwesomeIcons.fileInvoiceDollar,
                            color: goldcolor,
                            size: 50,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //text
                          Text(
                            translation(context).transfer_text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  //Detalles
                  Text(
                    translation(context).details_text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  //ONE paragraph saying: Transferencia de la cantidad de $amount, para comprar la cantidad de AmountTTC
                  Text(
                    translation(context).transfer_amount_text + " " +
                        conciliation.amount + " " + 
                        translation(context).to_purchase_amount_text + " " +
                        (conciliation.TTCAmount)+
                        " TTC",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  //fecha/hora
                  SizedBox(height: 20),
                  Text(
                    translation(context).date_hour_text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  //fecha/hora formato 28 de noviembre del 2020 12:00
                  SizedBox(height: 10),
                  //la hora debe estar en espanol
                  Text(
                    DateFormat('dd MMMM yyyy - hh:mm a', 'es')
                        .format(conciliation.created_at),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  //referencia
                  SizedBox(height: 20),
                  Text(
                    translation(context).reference_text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  //referencia
                  SizedBox(height: 10),
                  Text(
                    conciliation.reference,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 40),
                  //expanded para que ocupe todo el espacio y boton de confirmar
                  if(conciliation.status == "pending")
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {
                              //confirmar
                              //confirmar la transferencia
                              //si la transferencia es exitosa, mostrar mensaje de exito
                              //si la transferencia falla, mostrar mensaje de error
                              //si la transferencia es exitosa, navegar a la pantalla de reconciliaciones
                              //si la transferencia falla, navegar a la pantalla de reconciliaciones
                              //NavigationService.navigateTo(uiProvider.pages[uiProvider.selectedMainMenu]);
                              var id  = conciliation.id;
                              var data = {
                                "id": id,
                                "status": "rejected"
                              };
                              GlobalTools().showWaitDialog(
                                  waitText: translation(context).reconciliation_update_text);
                              HttpApi.postJson('/reconciliation/change_status', data).then((json) {
                                //close dialog

                                GlobalTools().closeDialog();

                                //show snackbar green, oferta actualizada
                                ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                                    .showSnackBar(
                                    SnackBar(
                                      content: Text(translation(context).status_updated_text,
                                          textAlign: TextAlign.center),
                                      backgroundColor: Colors.green,
                                    )
                                );
                                setState(() {
                                  conciliation.status = "rejected";
                                });
                              }).catchError((e) {
                                GlobalTools().closeDialog();
                                //show snackbar red , usuario o contraseña incorrectos

                                print(e);

                                ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                                    .showSnackBar(
                                    SnackBar(
                                      content: Text(translation(context).error_text,
                                          textAlign: TextAlign.center),
                                      backgroundColor: Colors.redAccent,
                                    )
                                );
                                print('error en: ${e}');
                              });


                            },
                            child: Text(translation(context).decline_text, style: TextStyle(color: backgroundcolor)),
                            style: ElevatedButton.styleFrom(

                                backgroundColor: Colors.grey,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold, color: backgroundcolor)),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {
                              //confirmar
                              //confirmar la transferencia
                              //si la transferencia es exitosa, mostrar mensaje de exito
                              //si la transferencia falla, mostrar mensaje de error
                              //si la transferencia es exitosa, navegar a la pantalla de reconciliaciones
                              //si la transferencia falla, navegar a la pantalla de reconciliaciones
                              //NavigationService.navigateTo(uiProvider.pages[uiProvider.selectedMainMenu]);
                              var id  = conciliation.id;
                              var data = {
                                "id": id,
                                "status": "approved"
                              };
                              GlobalTools().showWaitDialog(
                                  waitText: translation(context).reconciliation_update_text);
                              HttpApi.postJson('/reconciliation/change_status', data).then((json) {
                                //close dialog
                                GlobalTools().closeDialog();
                                print('json: ${json}');
                                //show snackbar green, oferta actualizada
                                ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                                    .showSnackBar(
                                    SnackBar(
                                      content: Text(translation(context).status_updated_text,
                                          textAlign: TextAlign.center),
                                      backgroundColor: Colors.green,
                                    )
                                );
                                setState(() {
                                  conciliation.status = "approved";
                                });
                              }).catchError((e) {
                                GlobalTools().closeDialog();
                                //show snackbar red , usuario o contraseña incorrectos

                                print(e);

                                ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                                    .showSnackBar(
                                    SnackBar(
                                      content: Text(translation(context).error_text,
                                          textAlign: TextAlign.center),
                                      backgroundColor: Colors.redAccent,
                                    )
                                );
                                print('error en: ${e}');
                              });

                            },
                            child: Text(translation(context).confirm, style: TextStyle(color: backgroundcolor)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: goldcolor,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ))
                  //boton de confirmar  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                color: goldcolor,
              )),
      ),
    );
  }
}
