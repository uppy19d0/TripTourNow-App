import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/ui/layouts/core_layaout.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/http/auth_response.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';

class Withdraw_Paypal extends StatefulWidget {
  const Withdraw_Paypal({Key? key}) : super(key: key);

  @override
  State<Withdraw_Paypal> createState() => _Withdraw_PaypalState();
}

class _Withdraw_PaypalState extends State<Withdraw_Paypal> {
  bool isloading = false;
  double balance = 0.0;
  bool isdisabled= false;
  double fee=0.0;
  double conversionrate= 1.0;

  //initialize montocontroller in 0.0
  TextEditingController _montocontroller = TextEditingController(text: '0.0');
  TextEditingController _addresscontroller = TextEditingController();
  var montoTTCcontroller = TextEditingController(text: '0');


  @override
  void initState() {
    // TODO: implement initState
    HttpApi.httpGet('/user/balance').then((value) {


      setState(() {
       // balance = value['balance'];
        //balance must be double
        balance = value['balance'].toDouble();
      });


    }).catchError((error) {
      print(error);
      print(error.data);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    User user = authProv.user!;
    double percentaje= user.percentaje;
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(translation(context).withdraw_funds_text),
        ),
        body: Container(
          height: double.infinity,
          color: backgroundcolor,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(height:40),
              Column(
                children: [
                  Text(
                    translation(context).available_for_withdraw_text,
                    style: TextStyle(
                        color: white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    balance.toStringAsFixed(2) + ' TTC' ,
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Container(
                child: Text(translation(context).withdraw_fund_to_text + ' Paypal',textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 20,),
              Text(translation(context).for_ttc_wallet_text, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
              //listTile with payment method Paypal
              // input for amount with icon on left and USD on right
              Container(
                padding: EdgeInsets.symmetric(vertical:20),
                    child: TextFormField(
                      controller: _montocontroller,
                      onChanged: (value) {
                        String text='0';
                        if(
                        value=='' || value=='0'
                        ){
                          fee=0;
                          text='0';
                        }else{
                          double rate= conversionrate;
                          print(rate);
                          fee = double.parse(value)/rate*(percentaje/100);
                          text = (double.parse(value)-fee).toString();
                        }
                        montoTTCcontroller.text=text;

                        if (value.isEmpty) {
                          setState(() {
                            isdisabled = true;
                          });
                        } else {
                         //amount cant be more than balance
                          if (double.parse(value) > balance) {
                            setState(() {
                              isdisabled = true;
                            });
                          } else {
                            setState(() {
                              isdisabled = false;
                            });
                          }
                        }
                      },
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon:  Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 10,),
                            Image.asset('assets/logo-ttc.png',width: 25,height: 25,),
                            SizedBox(width: 10,)
                          ],
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 10,),
                            Text('TTC', style: TextStyle(color: Colors.white),),
                            SizedBox(width: 10,)
                          ],
                        ),
                        suffixStyle: TextStyle(color: Colors.white),
                        hintText: translation(context).amount_text,
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    ),
              SizedBox(height: 10,),
              Text(translation(context).to_text + ' Paypal', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
              Container(
                padding: EdgeInsets.symmetric(vertical:20),
                child: TextFormField(
                  readOnly: true,
                  controller: montoTTCcontroller,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    suffixIcon:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 10,),
                        SvgPicture.asset('assets/icons/paypal.svg',
                            height: 20, semanticsLabel: 'Label'),
                        SizedBox(width: 10,)
                      ],
                    ),

                    suffixStyle: TextStyle(color: Colors.white),
                    hintText: translation(context).amount_text,
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(translation(context).comission_text + ':', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                  Text(fee.toString()+ ' USD', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 20,),
              //tasa de cambio neta
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(translation(context).exchange_rate_text + ':', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                  Text('1 TTC = 1 USD', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 20,),
              Text(translation(context).destination_address_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
              //boton de retirar fondos
              SizedBox(height: 10,),
              TextField(
                controller: _addresscontroller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  //user ttc icon and TTC texts as suffix,
                  //suffixicon, iconbutton
                  //suffixicon paste button
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.paste),
                        color: Colors.white,
                        onPressed: () async {
                          ClipboardData? data = await Clipboard.getData('text/plain');
                          if (data != null) {
                            setState(() {
                              _addresscontroller.text = data.text!;
                              ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                                  .showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        translation(context).text_pasted_text,style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.center),
                                    backgroundColor: Colors.greenAccent,
                                  )
                              );

                            });
                          }else{
                            //show snackbar , no hay texto para copiar
                            ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                                .showSnackBar(
                                SnackBar(
                                  content: Text(
                                      translation(context).no_text_to_paste_text,style: TextStyle(color: Colors.black),
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.grey[300],
                                )
                            );
                          }
                        },
                      ),

                    ],
                  ),
                  hintText: translation(context).paypal_email_text,
                  hintStyle: TextStyle(color: Colors.white),

                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
              //boton de retirar fondos
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isdisabled ? null : () {


                    if(_addresscontroller.text==''){
                      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                          .showSnackBar(
                          SnackBar(
                            content: Text(
                                translation(context).email_cant_be_empty_text,style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center),
                            backgroundColor: Colors.redAccent,
                          )
                      );

                      return;
                    }
                    //check if address is valid email
                    if(!_addresscontroller.text.contains('@')) {
                      ScaffoldMessenger.of(
                          NavigationService.navigatorKey.currentContext!)
                          .showSnackBar(
                          SnackBar(
                            content: Text(
                                translation(context).email_address_invalid_text,
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center),
                            backgroundColor: Colors.redAccent,
                          )
                      );

                      return;
                    }
                    //check if amount is more than balance
                    if(double.parse(_montocontroller.text)>balance){
                      ScaffoldMessenger.of(
                          NavigationService.navigatorKey.currentContext!)
                          .showSnackBar(
                          SnackBar(
                            content: Text(
                                translation(context).amount_cant_greater_balance_text,
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center),
                            backgroundColor: Colors.redAccent,
                          )
                      );

                      return;
                    }
//check if amount is less than 15
                    if(double.parse(_montocontroller.text)<15){
                      ScaffoldMessenger.of(
                          NavigationService.navigatorKey.currentContext!)
                          .showSnackBar(
                          SnackBar(
                            content: Text(
                                translation(context).amount_cant_lesser_text + ' 15',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center),
                            backgroundColor: Colors.redAccent,
                          )
                      );

                      return;
                    }
                    //amount cant be 0
                    if(double.parse(_montocontroller.text)==0){
                      ScaffoldMessenger.of(
                          NavigationService.navigatorKey.currentContext!)
                          .showSnackBar(
                          SnackBar(
                            content: Text(
                                translation(context).amount_cant_empty,
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center),
                            backgroundColor: Colors.redAccent,
                          )
                      );

                      return;
                    }


                    GlobalTools().showWaitDialog(
                        waitText: translation(context).please_wait);

                    var monto = _montocontroller.text;
                    var address= _addresscontroller.text;
                    var data= {
                      'deposit':monto,
                      'mode':'PAYPAL',
                      'amountCoin':monto,
                      'receiver':address,
                    };
                    HttpApi.postJson('/coin/withdraw', data).then((value) {
                      setState(() {
                        isloading = false;
                      });
                      //close the wait dialog
                      //redirect to buysuccess
                      Navigator.of(context).pop();
                      //fluro router navigate to buysuccess
                      NavigationService.replaceRemoveTo(Flurorouter.withdrawpaypalconfirmRoute);

                    }).catchError((error) {
                      print(error);
                      print(error.data);
                      setState(() {
                        isloading = false;
                      });
                    });
                    //fluro routere redirect
                  },

                  child: Text(translation(context).continue_text, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: goldcolor,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    disabledBackgroundColor: Colors.grey[300],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              //Tiempo Promedio de Retiro 45 minutos
              Text(translation(context).average_time_withdrawal_text,textAlign:TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14),),
  ]),
          )

    );
  }
}
