import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';
import 'package:http/http.dart' as http;
//fontawesoe icons
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuyWithBtcView extends StatefulWidget {
  const BuyWithBtcView({super.key});

  @override
  State<BuyWithBtcView> createState() => _BuyWithBtcViewState();
}

class _BuyWithBtcViewState extends State<BuyWithBtcView> {
  String adress= "bc1qp3wvyrf5lqdje3sa7wskxmq85nxsr7h6hapa67";
  double btcamount = 0.0;
  double ttcamount = 0.0;
  double btctax = 0.0;
  bool isloading = false;
  final _amountController = TextEditingController(text: '0');
  String fullname = '';


  void handlesubmit(){
    //if amount is 0 or null return
    if(_amountController.text=='0' || _amountController.text==null || _amountController.text==''){
      //show red snackbar
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(translation(context).amount_greater_zero)));
      return;
    }
    const bank= 'BTC';
    //get the user
    final authProv = Provider.of<AuthProvider>(context, listen: false);
    fullname = authProv.user!.fullname;
    var nData = {
      'name': fullname,
      'amount': _amountController.text,
      'TTCAmount': _amountController.text,
      'bank': 'BTC',
      'reference': 'BTC',
      'status': 'pending'
    };
    debugPrint(nData.toString());
    HttpApi.postJson('/reconciliation', nData).then((value) {
      print(value);
      if(value['status'] == 'success'){
        //print success 50 times
        NavigationService.replaceRemoveTo(
            Flurorouter.reconciliationConfirmRoute);

      }
      //navigate to success page
      //if error
      //show error message
    }).catchError((error) {
      print(error);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isloading = true;
    //get https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd
    //get the price of BTC in USD USE d
    const path = 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd';
    final response= http.get(Uri.parse(path));
    response.then((value) {
      print(value.body);
      //parse the json
      final json = value.body;
      final bitcoin = jsonDecode(json);
      var price = bitcoin['bitcoin']['usd'];
      print(price);
      price=price.toString();

      //get the price
    print(json);
      //set the price
      setState(() {
        btctax = double.parse(price);
        isloading = false;
      });
     // print(price);
    });
  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    //set the addresses
    return Scaffold(
        appBar: AppBar(
          //back icon
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //flurorouter my wallet
              NavigationService.replaceRemoveTo(Flurorouter.myWalletRoute);
            },
          ),
          title: Text(translation(context).buy_with_text + " BTC"),
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
          if (idx == uiProvider.selectedMainMenu) return;
          uiProvider.selectedMainMenu = idx;
          uiProvider.appBarReset();
          NavigationService.navigateTo(
              uiProvider.pages[uiProvider.selectedMainMenu]);
        }),
        //body stepper
        body: (isloading)?Container(
          color: backgroundcolor,
          child: Center(
            child: CircularProgressIndicator(
              color: goldcolor,
            ),
          ),
        ):Container(
          padding: EdgeInsets.all(10),
          color: backgroundcolor,
          child: ListView(
            children: [
              Text(translation(context).enter_amount_text + ' TTC '+ translation(context).to_purchase_using_text +  ' BTC', style: TextStyle(color: white,fontWeight: FontWeight.w100), ),
              SizedBox(height: 5,),
              Text(translation(context).amount_text, style: TextStyle(color: white),),
              SizedBox(height: 10,),
              TextFormField(
                cursorColor: goldcolor,
                controller: _amountController,
                style: TextStyle(color: white),
                onChanged: (value){
                  print('el monto es');
                  print(value);
                  setState(() {
                    //parse amountcontroller to double TTCamount
                    ttcamount  = double.parse(_amountController.text);

                   // Cantidad de Bitcoin = Cantidad de dólares / Precio actual de Bitcoin
                    btcamount = ttcamount / btctax;

                  });



                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: white),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('TTC', style: TextStyle(color: white),),
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
              SizedBox(height: 10,),
              //=amount * btcamount;
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(translation(context).price_in_text + ' BTC', style: TextStyle(color: goldcolor,fontWeight: FontWeight.w100),),
                  Text('= '+ (btcamount).toString(), style: TextStyle(color: goldcolor,fontWeight: FontWeight.w100),),

                ],
              ),
              //para comprar amount TTC debes enviar amount BTC a la siguiente direccion
              SizedBox(height: 5,),
              Text(
                translation(context).to_purchase_text + ' '+ttcamount.toString()+ ' TTC ' + translation(context).must_send_text + ' '+ btcamount.toString() + ' BTC ' + translation(context).to_next_address_text ,style: TextStyle(color: goldcolor),
              ),

              SizedBox(height: 20,),
              ListTile(
                //leading circle icon BTC, in orange
                leading: FaIcon(
                  FontAwesomeIcons.bitcoin,
                  //outline
                  //color #F2A900
                  color: btcorange,
                  size: 50,
                ),
                title:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("bc1qp-apa67", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: goldcolor),),

                   //ligth orange badge, with tex bec32 (P2WPKH)
                    SizedBox(height: 5,),
                    Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text("BEC32 (P2WPKH)", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),


                      ),
                    ),
                    SizedBox(
                      height: 5,

                    ),

                  ],
                ),
                trailing: Text('USD', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: white),),

                ),
              Container(
          padding: EdgeInsets.all(10),
child: Row(
                //icon address box
                children: [

                  Expanded(
                    child:
                    Text( adress, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.grey),),),
                  SizedBox(
                    width: 5,
                  ),
                  //iconbutton
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.copy,
                      color: goldcolor,
                      size: 20,
                    ),
                    onPressed: () {
                      //copy address  to clipboard
                      Clipboard.setData(
                          ClipboardData(text: adress));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(translation(context).copied_clipboard_text)));
                    },
                  ),


                ],
              ),


              ),
              SizedBox(height: 20,),
              Container(
                child: Center(
                  child:     QrImage(
                    backgroundColor: white,
                    data:
                    '${ adress}',
                    version: QrVersions.auto,
                    size: 200,
                  ),
                ),

              ),
              SizedBox(
                height: 20,
              ),
              //gold Continue button
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    handlesubmit();
                  },
                  child: Text(translation(context).continue_text, style: TextStyle(color: Colors.black),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15), backgroundColor: goldcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ));
  }
}
