import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:provider/provider.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';


class BuyWithPaypal extends StatefulWidget {
  const BuyWithPaypal({Key? key}) : super(key: key);

  @override
  State<BuyWithPaypal> createState() => _BuyWithPaypalState();
}

class _BuyWithPaypalState extends State<BuyWithPaypal> {
  var montocontroller = TextEditingController(text: '0');
  var montoTTCcontroller = TextEditingController(text: '0');
  //openpaypalpage
  void openpaypalpage(){
    double amount= double.parse(montocontroller.text);

    if(amount == 0 || amount == null){
      //red snackbar with text, "El monto no puede ser 0 o vacio" but dont use globaltools
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
          SnackBar(
            content: Text(
                translation(context).amount_greater_zero,
                textAlign: TextAlign.center),
            backgroundColor: Colors.redAccent,
          )
      );

      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UsePaypal(
            sandboxMode: true,
            clientId:
            "AVxmvw9XDpItdcjFtEIjgh_ZrHutCj2O4Amj34XziJ6eneXEYlcnnL7xP5ceXiWsW8_M6K0pUF25QUt-",
            secretKey:
            "EPaVbbwF3bgBF5sLDryt2H8k2Y3ze1uDELSVbBnTXSkYAZe0CIfekdL4lkI6JDa2apoD20jGu1_vEESq",
            returnURL: "https://triptourcoin.com/return",
            cancelURL: "https://triptourcoin.com/cancel",
            transactions:  [
              {
                "amount": {
                  "total": montocontroller.text,
                  "currency": "USD",
                  "details": {
                    "subtotal": montocontroller.text,
                    "shipping": '0',
                    "shipping_discount": 0
                  }
                },
                "description":
                "The payment transaction description.",
                // "payment_options": {
                //   "allowed_payment_method":
                //       "INSTANT_FUNDING_SOURCE"
                // },
                "item_list": {
                  "items": [
                    {
                      "name": "Compra TTC",
                      "quantity": 1,
                      "price": montocontroller.text,
                      "currency": "USD"
                    }
                  ],
                }
              }
            ],
            note: "Contact us for any questions on your order.",

            onSuccess: (Map params) async {
              //NavigationService.replaceRemoveTo(Flurorouter.enviarRoute);
              //print 20 times "success" using loop

              double amount= double.parse(montocontroller.text);
              var nData = {
                'deposit': montocontroller.text,
                'amount': amount,
                'mode': 'Paypal',
              };
              print(nData);

              HttpApi.postJson('/add/funds', nData).then((value) {
                print(value);
                if(value['status'] == 'success'){
                  //print success 50 times
                  NavigationService.replaceRemoveTo(
                      Flurorouter.homeRoute);

                }
                //navigate to success page
                //if error
                //show error message
              }).catchError((error) {
                print(error);
              });


            },
            onError: (error) {
              //show snachbacr error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${error.toString()}'),
                  backgroundColor: Colors.grey,
                ),
              );
            },
            onCancel: (params) {
              //show snachbacr error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translation(context).cancelled_text),
                  backgroundColor: Colors.grey,
                ),
              );
            }),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    double amount;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(translation(context).recharge_with_text + " PayPal", style: TextStyle(color: Colors.white)),


        ),
        bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
          if (idx == uiProvider.selectedMainMenu) return;
          uiProvider.selectedMainMenu = idx;
          uiProvider.appBarReset();
          NavigationService.navigateTo( uiProvider.pages[uiProvider.selectedMainMenu]);
        }),
        body:Container(
          color: backgroundcolor,
          height: double.infinity,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),

            children: [
              Text(translation(context).buy_ttc_text ,style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              //label for "Monto"
              //input for "Monto"
              SizedBox(height: 40,),
              Text(translation(context).amount_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
              SizedBox(height: 10,),
              //input for monto with bitcoin icon on the right
              TextFormField(
                controller: montocontroller,
                style: TextStyle(color: white),
                onChanged: (value){
                  print('el monto es');
                  print(value);
                  montoTTCcontroller.text= value;

                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "0.00",
                  hintStyle: TextStyle(color: white),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('USD', style: TextStyle(color: white),),
                      SizedBox(width: 10,),
                    ],
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 40,),
              Text(translation(context).amount_to_receive_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
              SizedBox(height: 10,),
              TextFormField(
                style: TextStyle(color: white),
                //print initial value with 2 decimals
                controller: montoTTCcontroller,
                onChanged: (value){
                  print('el monto es');
                  print(value);
                  montocontroller.text= value;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(" TTC (Trip Tour Coin)", style: TextStyle(color: white),),
                      SizedBox(width: 10,),
                    ],
                  ),
                  hintStyle: TextStyle(color: white),
                  //use assets/logo-ttc.png as prefix icon
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 10,),
                      Image.asset('assets/logo-ttc.png',width: 25,height: 25,),
                      SizedBox(width: 10,),
                    ],
                  ),


                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Container(
                child: ElevatedButton(
                  //color gold
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: goldcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    onPressed: () => {


                      openpaypalpage()

                    },
                    child:  Text(translation(context).recharge_with_text + " PayPal")),

              ),
              SizedBox(height: 40,),
              Text(translation(context).if_not_paypal_text ,style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w100),textAlign: TextAlign.center,),
            ],
          ),
        )
      //i
    );
  }
}
