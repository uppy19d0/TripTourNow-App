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

class BuyWithUsdtView extends StatefulWidget {
  const BuyWithUsdtView({super.key});

  @override
  State<BuyWithUsdtView> createState() => _BuyWithUsdtViewState();
}

class _BuyWithUsdtViewState extends State<BuyWithUsdtView> {

  //init 0 to the amount
  final _amountController = TextEditingController(text: '0');
  String? fullname = '';
  void handlesubmit(){
    //if amount is 0 or null return
    if(_amountController.text=='0' || _amountController.text==null || _amountController.text==''){
      //show red snackbar
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(translation(context).amount_greater_zero)));
      return;
    }
    const bank= 'USDT';
    //get the user
    final authProv = Provider.of<AuthProvider>(context, listen: false);
    fullname = authProv.user!.fullname;
    var nData = {
      'name': fullname,
      'amount': _amountController.text,
      'TTCAmount': _amountController.text,
      'bank': 'USDT',
      'reference': 'USDT',
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
  Widget build(BuildContext context) {
    final String trc20PaymentAddress;
    final String erc20PaymentAddress;
    //erc20 0x63784D7d5D5DA5a8cc835ABdf322fdd1Bb96bdd4
    //trc20 TGDYnBPAw86xeQjypFvJ3cGmhnbuX9Keui
    erc20PaymentAddress = "0x63784D7d5D5DA5a8cc835ABdf322fdd1Bb96bdd4";

    trc20PaymentAddress = "TGDYnBPAw86xeQjypFvJ3cGmhnbuX9Keui";
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
          title: Text(translation(context).buy_with_text + " USDT"),
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
        body:       Container(
          padding: EdgeInsets.all(10),
          color: backgroundcolor,
          child:ListView(

          children: [


         Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text(translation(context).amount_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                SizedBox(height: 10,),
                //input for monto with bitcoin icon on the right
                TextFormField(
                  controller: _amountController,
                  style: TextStyle(color: white),
                  onChanged: (value){
                    print('el monto es');
                    print(value);


                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: white),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('USDT', style: TextStyle(color: white),),
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
                Row(
                  //space between
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translation(context).amount_to_receive_text + ":",style: TextStyle(color: goldcolor,fontSize: 12,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                    SizedBox(width: 10,),
                    Text( (_amountController.text!=''? _amountController.text : '0.00' ) + ' TTC',style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  ],
                ),
                SizedBox(height: 10,),
                SizedBox(height: 20),
                Container(
                  child: Center(
                      child: Text(translation(context).address_text + " TRC-20",style: TextStyle(color: goldcolor,fontSize: 30,fontWeight: FontWeight.bold),)
                  ),

                ),

                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        trc20PaymentAddress,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.copy),
                      color: Colors.white,
                      onPressed: () {
                        //copy trc20PaymentAddress to clipboard
                        Clipboard.setData(
                            ClipboardData(text: trc20PaymentAddress));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(translation(context).copied_clipboard_text)));

                      },
                    ),
                  ],
                ),

                SizedBox(height: 20),
                SizedBox(height: 20),
                Container(
                  child: Center(
                      child:     QrImage(
                        backgroundColor: white,
                        data:
                        '${trc20PaymentAddress}?amount=${_amountController.text}',
                        version: QrVersions.auto,
                        size: 200,
                      ),
                  ),

                ),
                SizedBox(height: 20),

                //gold Continue button
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      handlesubmit();
                    },
                    child: Text(translation(context).continue_text, style: TextStyle(fontSize: 18, color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15), backgroundColor: goldcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child:
                Text(
                  translation(context).please_check_address_text,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),),
SizedBox(height: 20,)
              ],
            ),
          ),
        ])));
  }
}
