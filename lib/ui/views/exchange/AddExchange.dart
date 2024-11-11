import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/models/CasaDeCambio.dart';
import 'package:trip_tour_coin/shared/global_dialog.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/http/error_http.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';
import '../../../widgets/button_widget/primary_button.dart';
//import svg image library
import 'package:flutter_svg/flutter_svg.dart';

import 'SelectHouse.dart';

class AddExchange extends StatefulWidget {
  const AddExchange({Key? key}) : super(key: key);

  @override
  State<AddExchange> createState() => _AddExchangeState();
}

class _AddExchangeState extends State<AddExchange> {
  //textediting controller for amount initialize value in 0
  TextEditingController amountController = TextEditingController(text: '0.0');

  //textediting controller for amount to receive
  TextEditingController amountReceiveController =
      TextEditingController(text: '0.0');

  double balance = 0.0;
  double amount = 0.0;
  double fee = 0.0;
  double amountReceive = 0.0;
  double exchangerate = 0.0;

  late CasaDeCambio selectedhouse = CasaDeCambio(
    id: 0,
    name: 'Name',
    phone: 'Phone',
    address: 'Address',
    usd: false,
    eur: false,
    gbp: false,
    dop: false,
    cad: false,
    chf: false,
    image: '',
    googlemaplink: '',
  );
  List<DropdownMenuItem<String>> _currencies = [
    //USD, EUR, CAD
    DropdownMenuItem<String>(
        child: Row(children: [
          //svg flag from assets/flags make it circular
          SvgPicture.asset(
            'assets/flags/usd.svg',
            height: 20,
            width: 20,
          ),
          SizedBox(width: 10),

          Text(
            'USD',
            style: TextStyle(color: Colors.white),
          )
        ]),
        value: 'USD'),
    DropdownMenuItem<String>(
        child: Row(children: [
          //svg flag from assets/flags make it circular
          SvgPicture.asset(
            'assets/flags/eur.svg',
            height: 20,
            width: 20,
          ),
          SizedBox(width: 10),

          Text(
            'EUR',
            style: TextStyle(color: Colors.white),
          )
        ]),
        value: 'EUR'),
    DropdownMenuItem<String>(
        child: Row(children: [
          //svg flag from assets/flags make it circular
          SvgPicture.asset(
            'assets/flags/cad.svg',
            height: 20,
            width: 20,
          ),
          SizedBox(width: 10),

          Text(
            'CAD',
            style: TextStyle(color: Colors.white),
          )
        ]),
        value: 'CAD'),
    //dop
    DropdownMenuItem<String>(
        child: Row(children: [
          //svg flag from assets/flags make it circular
          SvgPicture.asset(
            'assets/flags/dop.svg',
            height: 20,
            width: 20,
          ),
          SizedBox(width: 10),

          Text(
            'DOP',
            style: TextStyle(color: Colors.white),
          )
        ]),
        value: 'DOP'),
    //LIBRA esterlina
    DropdownMenuItem<String>(
        child: Row(children: [
          //svg flag from assets/flags make it circular
          SvgPicture.asset(
            'assets/flags/gbp.svg',
            height: 20,
            width: 20,
          ),
          SizedBox(width: 10),

          Text(
            'GBP',
            style: TextStyle(color: Colors.white),
          )
        ]),
        value: 'GBP'),
  ]; //
  //prepare usd as default value
  String _selectedCurrency = 'USD';
  //create a dictionary with the converts from ttc to each currency, the value of the TTC is same as usd
  Map<String, double> _currencyConvert = {
    'USD': 1.0,
    'EUR': 0.85,
    'CAD': 1.25,
    'DOP': 58.0,
    'GBP': 0.72
  };

  @override
  void initState() {
    //await for get offers
    HttpApi.httpGet('/user/balance').then((value) {
      //balance = value['balance'].;
      //type 'int' is not a subtype of type 'double'
      setState(() {
        balance = value['balance'].toDouble();
      });
      //PR
      print('entra aqui');
    }).catchError((error) {
      //if error is ErrorHttp
      if (error is ErrorHttp) {
        //if error is 401
        //if error data message is unauthorized
        if (error.data['message'] == 'unauthorized') {
          //show dialog
          print('unauthorized + redireccionar a login');
          //redirect to login using flurorouter
          Flurorouter.router
              .navigateTo(context, '/login', transition: TransitionType.fadeIn);
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
            onPressed: () =>
                {NavigationService.replaceRemoveTo(Flurorouter.homeRoute)}),
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
          //add a listview
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                SizedBox(height: 5),
                Image.asset('assets/logo-ttc.png', width: 70, height: 70),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(translation(context).available_text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(balance.toString() + " TTC",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20),
                //place a golden button to go to the exchange at the bottom of the list
                Card(
                    color: Colors.black,
                    //card title must be "tu envias, subtitle will be an input" for the ammount , the trailing will be TTC and the ttc icon
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: ListTile(
                        title: Text(translation(context).you_send_text,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        subtitle: TextField(
                          controller: amountController,
                          //onchange
                          onChanged: (value) {
                            //if value is empty
                            if (value.isEmpty) {
                              //set the value to 0
                              amount = 0;
                              //else
                            } else {
                              //set the value to the value of the input
                              amount = double.parse(value);
                            }
                            //if value <0
                            if (amount < 0) {
                              //set the value to 0
                              amount = 0;
                              //set the value of the input to 0
                              amountController.text = '0';
                            }
                            //change the value of the input

                            amountReceiveController.text =
                                (amount * _currencyConvert[_selectedCurrency]!)
                                    .toStringAsFixed(2);
                            //update the values of   double fee, amountReceive, exchangerate

                            setState(() {
                              fee = amount * 0.05;
                              amountReceive = amount - fee;
                              exchangerate =
                                  _currencyConvert[_selectedCurrency]!;
                            });
                          },

                          keyboardType: TextInputType.number,
                          //min value 0 and max value 999999999

                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset('assets/logo-ttc.png', width: 30),
                            SizedBox(width: 5),
                            Text('TTC',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20)),
                          ],
                        ),
                      ),
                    )

                    //get http://
                    ),
                //saldo insuficiente en rojo
                //if amount > balance
                if (amount > balance)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(translation(context).insufficient_balance_text,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                Card(
                    color: Colors.black,
                    //this time the trailing will be a dropdown with the currenies (usd, eur, )
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: ListTile(
                        title: Text(translation(context).you_receive_text,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        subtitle: TextField(
                          controller: amountReceiveController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.white, fontSize: 24),
                          onChanged: (value) {
                            //if value is empty
                            if (value.isEmpty) {
                              //set the value to 0
                              amountReceive = 0;
                              //else
                            } else {
                              //set the value to the value of the input
                              amountReceive = double.parse(value);
                            }
                            //if value <0
                            if (amountReceive < 0) {
                              //set the value to 0
                              amountReceive = 0;
                              //set the value of the input to 0
                              amountReceiveController.text = '0';
                            }
                            //change the value of the input
                            amountController.text = (amountReceive /
                                    _currencyConvert[_selectedCurrency]!)
                                .toStringAsFixed(2);
                            //      update the values of   double fee, amountReceive, exchangerate

                            setState(() {
                              fee = amountReceive * 0.05;
                              amount = amountReceive + fee;
                              exchangerate =
                                  _currencyConvert[_selectedCurrency]!;
                            });
                          },
                        ),
                        //trailing the dropdown
                        trailing: DropdownButton<String>(
                          dropdownColor: Colors.black,
                          items: _currencies,
                          value: _selectedCurrency,
                          onChanged: (value) {
                            setState(() {
                              _selectedCurrency = value!;
                              amountReceiveController.text =
                                  (double.parse(amountController.text) *
                                          _currencyConvert[_selectedCurrency]!)
                                      .toStringAsFixed(2);
                              //update the values of   double fee, amountReceive, exchangerate
                              fee = double.parse(amountController.text) * 0.01;
                              amountReceive =
                                  double.parse(amountController.text) - fee;
                              exchangerate =
                                  _currencyConvert[_selectedCurrency]!;
                            });
                            //update the selected currency
                            print(_selectedCurrency);
                            //update the amount to receive
                          },
                        ),
                      ),
                    )),
                SizedBox(height: 10),
                Card(
                    color: Colors.black,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        //aling spacebetween
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
//first row               //golden label "detalles del intercambio"
                          Text(translation(context).exchange_details_text,
                              style: TextStyle(color: goldcolor, fontSize: 16)),
                          //row "fee"
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Fee',
                                  style: TextStyle(color: Colors.white)),
                              Text((fee).toString() + ' TTC',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          SizedBox(height: 10),
                          //row monto a convertir
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(translation(context).amount_to_convert_text,
                                  style: TextStyle(color: Colors.white)),
                              Text(amount.toString() + ' TTC',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          //row tipo de cambio
                          SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(translation(context).exchange_type_text,
                                  style: TextStyle(color: Colors.white)),
                              Row(
                                children: [
                                  Text('1 TTC = ',
                                      style: TextStyle(color: Colors.white)),
                                  Text(
                                      _currencyConvert[_selectedCurrency]!
                                              .toString() +
                                          ' ' +
                                          _selectedCurrency,
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          //svg image from assets/flags/usd.svg

                          //row "monto a recibir"
                        ],
                      ),
                    )),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    //navigator.push SelectHouse
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SelectHouse(callback: (house) {
                                  setState(() {
                                    selectedhouse = house;
                                  });
                                  print(selectedhouse.name);
                                  if (Navigator.of(context).canPop()) {
                                    Navigator.of(context).pop();
                                  }
                                })));
                  },
                  child: Card(
                      color: Colors.black,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              Text(
                                  translation(context).which_currency_text,
                                  style: TextStyle(
                                      color: goldcolor, fontSize: 16)),
                              SizedBox(height: 10),
                              (selectedhouse.id == 0)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(translation(context).select_currency_text,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        )
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(selectedhouse.name,
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        )
                                      ],
                                    )
                            ],
                          ))),
                ),
                //golden button "intercambiar"
                SizedBox(height: 10),
                //golden elevated button
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: ElevatedButton(
                    onPressed: (balance < amount ||
                            amount == 0 ||
                            selectedhouse.id == 0)
                        ? null
                        : () {
                            //define ndata
                            var ndata = {
                              "amount": amount,
                              "currency": _selectedCurrency,
                              "house_id": selectedhouse.id,
                            };
                            GlobalTools().showWaitDialog(
                                waitText: translation(context).please_wait);
                            //post to roue exchange
                            try {
                              HttpApi.postJson('/exchange', ndata).then((value) {
                                //if the response is ok
                                GlobalTools().closeDialog();
                                print(value);
                                NavigationService.replaceRemoveTo(
                                    Flurorouter.successExchangeRoute);


                              });
                            } catch (e) {
                              print(e);
                              print('error');

                              //show dialog
                              GlobalTools().closeDialog();
                              //show red snackbar
                              final snackBar = SnackBar(
                                content: Text(translation(context).something_wrong_error),
                                backgroundColor: Colors.red,
                              );


                            }
                          },
                    //show dialog
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(translation(context).exchange_text,
                              style: TextStyle(color: Colors.black)),
                          SizedBox(width: 10),
                          //echange icon
                          Icon(Icons.currency_exchange, color: Colors.black),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldcolor,
                      disabledBackgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    //disabled style gray
                  ),
                )
              ])),
    );
  }
}
