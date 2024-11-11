import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/models/Offer.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/http/auth_response.dart';
import '../../../models/http/error_http.dart';
import '../../../providers/ui_provider.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';

class AdminOfferDetails extends StatefulWidget {
  final Offer offer;
  const AdminOfferDetails({Key? key, required this.offer}) : super(key: key);

  @override
  State<AdminOfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<AdminOfferDetails> {
  late Offer oferta;
  DateFormat dateFormat = DateFormat("E, yyyy-MM-dd ");

  //inititalize number controller to number 1
  TextEditingController _percentajecontroller =
      TextEditingController(text: '0');

  double total = 0.0;

  //get the offer from the offer argument
  @override
  void initState() {
    setState(() {
      oferta = widget.offer;
      total = oferta.price;
      _percentajecontroller.text = oferta.percentaje.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).manage_offer_text,
          style: TextStyle(fontSize: 16),
        ),
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
          height: double.infinity,
          width: double.infinity,
          color: backgroundcolor,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            children: [
              //status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translation(context).status_text + ": ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    (oferta.status == 'pending' || oferta.status == 'draft')
                        ? translation(context).waiting_for_approval
                        : oferta.status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(oferta.urlPost),
                          fit: BoxFit.cover)),
                ),
              ),
              //title bold and subtitle normal
              SizedBox(
                height: 10,
              ),
              Text(
                oferta.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                oferta.description,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              //number input with + and - buttons
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
//TTC ICON PNG
                  Image.asset(
                    'assets/logo-ttc.png',
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //total with only 2 decimals
                  Text(
                    total.toStringAsFixed(2),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'TTC',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //row spacebetween gold text both sides
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    oferta.bought.toString() + " " + translation(context).purchased_text + " " ,
                    style: TextStyle(
                      color: goldcolor,
                      fontSize: 12,
                    ),
                  ),
                  //print la oferta vence en format dateFormat.format(oferta.endDate)
                  Text(
                    translation(context).offer_expires_text + ": " + dateFormat.format(oferta.expireDate),
                    style: TextStyle(
                      color: goldcolor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //label white Descripcion de la oferta
              Text(
                translation(context).offer_description_text,
                style: TextStyle(
                    color: goldcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              //description text
              Text(
                oferta.description,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(
                height: 20,
              ),
              //ubicacion y  contactos gold
              Text(
                translation(context).location_n_contacts_text,
                style: TextStyle(
                    color: goldcolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              //tel . +1 800 000 0000
              Text(
                'Tel. ' + oferta.phone,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(
                height: 5,
              ),
              //address
              Text(
                oferta.address,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(
                height: 20,
              ),
              //input for percentaje of discount
              Text(
                translation(context).offer_percentaje_text,
                style: TextStyle(
                    color: goldcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                Expanded(
                  child: TextFormField(
                    //min value 0 and max value 100

                    controller: _percentajecontroller,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.percent,
                        color: Colors.white,
                        size: 20,
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        if(double.parse(value) > 100)
                          _percentajecontroller.text = '100';
                        if(double.parse(value) < 0)
                          _percentajecontroller.text = '0';

                        total = oferta.price -
                            (oferta.price * (double.parse(value) / 100));
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                //gold button, text black, guardar cambios
                ElevatedButton(
                  onPressed: () {
                    //show waiting dialog from globaltools
                    GlobalTools().showWaitDialog(
                        waitText: translation(context).updating_offer_percentaje_text);
                    //call updateOffer from api
                    final data = {'id': oferta.id, 'porcentaje': _percentajecontroller.text};

                    HttpApi.postJson('/post/change_porcentaje', data).then((json) {
                      //close dialog
                      GlobalTools().closeDialog();
                      widget.offer.percentaje = double.parse(_percentajecontroller.text);
                      //show snackbar green, oferta actualizada
                      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                          .showSnackBar(
                          SnackBar(
                            content: Text(translation(context).updated_offer_text,
                                textAlign: TextAlign.center),
                            backgroundColor: Colors.green,
                          )
                      );
                    }).catchError((e) {
                      GlobalTools().closeDialog();
                      //show snackbar red , usuario o contraseña incorrectos



                      if (e is ErrorHttp) {
                        print(e.data);
                        ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                            .showSnackBar(
                            SnackBar(
                              content: Text(translation(context).error_text,
                                  textAlign: TextAlign.center),
                              backgroundColor: Colors.redAccent,
                            )
                        );

                      }
                      print('error en: ${e}');
                    });


                  },
                  child: Text(
                    translation(context).update_text,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), backgroundColor: goldcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 20,
              ),
              //row with 3 buttons
              Text(translation(context).change_offer_status_text, style: TextStyle(color: goldcolor, fontSize: 16, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if(widget.offer.status != 'inactive')
                      OutlinedButton(
                        onPressed: () {
                          //show waiting dialog from globaltools
                          GlobalTools().showWaitDialog(
                              waitText: translation(context).updating_offer_status_text);
                          //call updateOffer from api
                          final data = {'id': oferta.id, 'status': 'inactive'};

                          HttpApi.postJson('/post/change_status', data).then((json) {
                            //close dialog
                            GlobalTools().closeDialog();
                            setState(() {
                              widget.offer.status = 'inactive';
                            });
                            //show snackbar green, oferta actualizada
                            ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                                .showSnackBar(
                                SnackBar(
                                  content: Text(translation(context).updated_offer_text,
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.green,
                                )
                            );
                          }).catchError((e) {
                            GlobalTools().closeDialog();
                            print('error');
                            print(e.data);
                            //show snackbar red , usuario o contraseña incorrectos
                        });
                        },
                        child: Text(
                          translation(context).decline_text,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          side: BorderSide(color: Colors.grey, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      //outilined gold button, rechazar
                      SizedBox(
                        width: 5,
                      ),
                      if(widget.offer.status != 'active')
                      OutlinedButton(
                        onPressed: () {
                          //show waiting dialog from globaltools
                          GlobalTools().showWaitDialog(
                              waitText: translation(context).updating_offer_status_text);
                          //call updateOffer from api
                          final data = {'id': oferta.id, 'status': 'active'};

                          HttpApi.postJson('/post/change_status', data).then((json) {
                            //close dialog
                            GlobalTools().closeDialog();
                            setState(() {
                              widget.offer.status = 'active';
                            });
                            //show snackbar green, oferta actualizada
                            ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                                .showSnackBar(
                                SnackBar(
                                  content: Text(translation(context).updated_offer_text,
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.green,
                                )
                            );
                          }).catchError((e) {
                            GlobalTools().closeDialog();
                            print('error');
                            print(e.data);
                            //show snackbar red , usuario o contraseña incorrectos
                          });
                        },
                        child: Text(
                          translation(context).approve_text,
                          style: TextStyle(
                              color: goldcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          side: BorderSide(color: goldcolor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                    ],
                  ),



            ],
          )),
    );
  }
}
