import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/theme.dart';
import 'package:trip_tour_coin/ui/layouts/core_layaout.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../shared/global_dialog.dart';
//import the needed packages to scan QR code
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'barcode_scanner_window.dart';

class EnviarPage extends StatefulWidget {
  const EnviarPage({Key? key}) : super(key: key);

  @override
  State<EnviarPage> createState() => _EnviarPageState();
}

class _EnviarPageState extends State<EnviarPage> {
  bool isloading = false;
  double balance = 0.0;
  bool isdisabled= false;
  String address = '';

  TextEditingController _montocontroller = TextEditingController();
  TextEditingController _addresscontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    HttpApi.httpGet('/user/balance').then((value) {


      setState(() {
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
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    final authProv = Provider.of<AuthProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(translation(context).send_text + ' ', style: TextStyle(color: Colors.white)),
          //icon to go back
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
            onPressed: () {
              //reset appbar
              uiProvider.appBarReset();
              //navigate to mywallet
              NavigationService.navigateTo(Flurorouter.myWalletRoute);
            },
          ),

        ),

        bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
          if (idx == uiProvider.selectedMainMenu) return;
          uiProvider.selectedMainMenu = idx;
          uiProvider.appBarReset();
          NavigationService.navigateTo( uiProvider.pages[uiProvider.selectedMainMenu]);
        }),
        body: Container(
      color: backgroundcolor,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child:ListView(
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(translation(context).amount_text, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
              //print balance with two decimals
              Text('\$${balance.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
            ],

          ),
          SizedBox(height: 20,),
          TextField(
            controller: _montocontroller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              //user ttc icon and TTC texts as suffix,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 10,),
                  Image.asset('assets/logo-ttc.png',width: 25,height: 25,),
                  SizedBox(width: 10,),
                  Text('TTC', style: TextStyle(color: Colors.white),),
                  SizedBox(width: 10,)
                ],
              ),
              hintText: translation(context).write_amount_text,
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
          //max amount label format $0.00
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('\$', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
              SizedBox(width:5,),
              Text('${balance.toStringAsFixed(2)}', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
            ],

          ),
          SizedBox(height: 40,),
          //print balance with two decimals, and $ sign before
          Text(translation(context).receiver_text, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          //write the same code as above, but with a suffix icon to scan the qr code, and a function to scan the qr code
          TextField(
            controller: _addresscontroller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              //user ttc icon and TTC texts as suffix,
              //suffixicon, iconbutton
              suffixIcon: IconButton(
                onPressed: (){
                  print('scan qr code');
                  Navigator.of(context).push(

                    MaterialPageRoute(
                      builder: (context) =>  BarcodeScannerWithScanWindow(callback: (value){
                        print(value);
                        _addresscontroller.text = value;

                      //pop navigation if can pop
                        if(Navigator.of(context).canPop()){
                          Navigator.of(context).pop();
                        }
                        //show gray snackbar with the text "QR code scanned successfully"
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(translation(context).qr_code_successful),
                            backgroundColor: Colors.grey,
                          ),
                        );
                      },),
                    ),
                  );

                },
                icon: Icon(Icons.qr_code_scanner, color: Colors.white,),
              ),
              hintText: translation(context).write_address_text,
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

          SizedBox(height: 40,),
          ElevatedButton(
            onPressed: (isdisabled)? null :() {


              GlobalTools().showWaitDialog(
                  waitText: translation(context).please_wait);

              Provider.of<UiProvider>(context, listen: false)
                  .selectedMainMenu = 0; // Rein
              double parsedAmount= 0;
              //if the amount is empty, show a red snackbar with the text "Amount is required"
              if(_montocontroller.text.isEmpty){
                GlobalTools().closeDialog();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('El monto es requerido'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              //if the amount is greater than the balance, show a red snackbar with the text "Amount is greater than balance"
              if(double.parse(_montocontroller.text) > balance){
                GlobalTools().closeDialog();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('El monto es mayor al balance'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              //if the address is empty, show a red snackbar with the text "Address is required"
              if(_addresscontroller.text.isEmpty){
                GlobalTools().closeDialog();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('La dirección es requerida'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              var amount = double.parse(_montocontroller.text);
              var ndata = {
                'amount': amount,
                'receiverAddress': _addresscontroller.text,
                'type': 'moneySend',
              };
              HttpApi.postJson('/transaction/create', ndata).then((value) {
                if(value['status'] == 'success'){
                  GlobalTools().closeDialog();
                  //Navigator.pushNamed(context, '/success');
                  NavigationService.replaceRemoveTo(
                      Flurorouter.confirmationRoute);
                }

              }).catchError((error) {
                print(error);
                print(error.data);

              });
            },
            child: Text(translation(context).send_text,style:TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: (isdisabled)?Colors.white: Colors.black,
            )),

            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: greycolor, backgroundColor: goldcolor,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),

            ),),
          ],
      )
    ));
  }

  void handleSubmit() {
    setState(() {
      isdisabled = true;
    });

  }
}
