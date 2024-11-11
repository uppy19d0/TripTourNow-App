//
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/ui/layouts/core_layaout.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';
import 'buywithcard.dart';
import '../../../services/navigation_service.dart';


class ComprarPage extends StatefulWidget {
  const ComprarPage({Key? key}) : super(key: key);

  @override
  State<ComprarPage> createState() => _ComprarPageState();
}

class _ComprarPageState extends State<ComprarPage> {
   double monto = 0.0;
  double montoTTC = 0.0;
  double montoBTC = 0.0;
  double montoETH = 0.0;
  double montoUSDT = 0.0;
  bool isloading = false;
  bool isdisabled= false;
   var montocontroller = TextEditingController(text: '0');
   var montoTTCcontroller = TextEditingController(text: '0');
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  //handle submit
  void handleSubmit() async {

    setState(() {
      isloading = true;
    });
    //parse amount to double

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //montocontroller
    return CoreLayout(child: (isloading)? Container(
      color: backgroundcolor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    )
    :Container(
      color: backgroundcolor,
      padding : EdgeInsets.symmetric(horizontal: 40, vertical: 20),

      child: ListView(
        children: [
          //white paragrahp bold 3 lines
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
          //button
          ElevatedButton(
            onPressed: (isdisabled)? null :() {

              double amount= double.parse(montocontroller.text);
              var nData = {
                'deposit': monto,
                'amount': amount,
                'mode': 'Paypal',
              };
              print(nData);

              //if amount is 0 or null show snackbar. red
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
              GlobalTools().showWaitDialog(
                  waitText: translation(context).please_wait);
              Provider.of<UiProvider>(context, listen: false)
                  .selectedMainMenu = 0; // Reinicia el menu
              //push buywithcard
              //navigator.push
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => BuyWithCard(amount: amount),
                ),
              );
              print('se manda');
            },
            child: Text(translation(context).purchase_text ,style:TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: (isdisabled)?Colors.white: Colors.black,
            )),

            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: greycolor, backgroundColor: goldcolor,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),

            ),),
          //white centered text
          SizedBox(height: 40,),
          Text(translation(context).if_not_paypal_text ,style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w100),textAlign: TextAlign.center,),
        ],



      )
    ));
  }
}
