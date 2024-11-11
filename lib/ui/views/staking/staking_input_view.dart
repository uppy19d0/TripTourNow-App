import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/ui/views/staking/staking_stake_view.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/Stake.dart';
import '../../../models/http/error_http.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';


class StakingInputView extends StatefulWidget {
  const StakingInputView({Key? key}) : super(key: key);

  @override
  State<StakingInputView> createState() => _StakingInputViewState();
}

class _StakingInputViewState extends State<StakingInputView> {
  double balance = 0.0;

  double porcentaje = 0.0;

  List<String> items = [
    '1 mes',
    '3 meses',
    '6 meses',
    '1 año',
  ];
  //number of days linked 1month, 3months, 6months, 1year
  List<int> days = [
    30,
    90,
    180,
    365,
  ];

  //percentajes linked 1month, 3months, 6months, 1year
  List<double> percentajes = [
    0.15,
    0.20,
    0.25,
    0.30,
  ];
  var amountControl = TextEditingController(text: '0.0');
  double amount = 0.0;

  String selectedvalue= '1 mes';
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
        title: Text('Staking'),
        //icon to go back
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => NavigationService.replaceRemoveTo(Flurorouter.stakingRoute)
        ),
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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Text(translation(context).set_amount_text, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold )),
            SizedBox(height: 15),
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

            Text(translation(context).percentaje_to_earn_text, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),
            SizedBox(height: 5),
            //
           //show percentaje based on selecteditem

            Text((percentajes[items.indexOf(selectedvalue)]*100).toString() + "%",
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(translation(context).duration_text, style: TextStyle(color: white),),
            //make dropdown with array of items
            DropdownButton<String>(

              dropdownColor: Colors.black,


              value: selectedvalue,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              iconSize: 24,
              style: const TextStyle(color: Colors.white),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String? newValue) {
                //update amount
                double aux = double.parse(amountControl.text);

                amount = aux * percentajes[items.indexOf(newValue!)];


                setState(() {
                  selectedvalue = newValue!;
                });
              },
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            SizedBox(height: 10),
            Container(child:
            Text(translation(context).percentaje_varies_text, style: TextStyle(color: goldcolor, fontSize: 10,  )),

            ),
            SizedBox(height:20),
            Text(translation(context).amount_to_set_text, style: TextStyle(color: white),),
            SizedBox(height: 0),
            TextFormField(


              style: TextStyle(color: white),
              controller: amountControl,
              onChanged: (value){


                //if text is empty set amount to 0

                  amount = double.parse(value);


                //validate amount
                if(amount > balance){
                  print('amount is greater than balance');
                  amount = balance;
                  amountControl.text = balance.toStringAsFixed(0);
                  //show bottom snackbar with error
                  ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                      .showSnackBar(
                      SnackBar(
                        content: Text(
                            translation(context).amount_cant_greater_balance_text, textAlign: TextAlign.center),
                        backgroundColor: Colors.redAccent,
                      )
                  );
                }

                //amount cant be less tan 0
                if(amount < 0){
                  print('amount is less than 0');
                  amount = 0;
                  amountControl.text = '0';
                  //show bottom snackbar with error
                  ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                      .showSnackBar(
                      SnackBar(
                        content: Text(
                            translation(context).amount_cant_lesser_text + ' 0', textAlign: TextAlign.center),
                        backgroundColor: Colors.redAccent,
                      )
                  );
                }
                setState(() {
                  
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 10,),
                    Image.asset('assets/logo-ttc.png',width: 25,height: 25,),
                    SizedBox(width: 10,),
                  ],
                ),
                hintStyle: TextStyle(color: white),
                labelStyle: TextStyle(color: white),

                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(translation(context).estimated_profit_text, style: TextStyle(color:goldcolor, fontSize: 16, fontWeight: FontWeight.w400 )),
                Spacer(),
                //show estimated profit based on selecteditem and the amount
                Text(((double.parse(amountControl.text)) * percentajes[items.indexOf(selectedvalue)]).toStringAsFixed(2)+ " TTC",
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                //same code above but w 2 decimals
                

                //txt amount
                //print the value of amountcontrol *2







              ],
            ),
            SizedBox(height: 2),
            Divider(color: Colors.white),
            SizedBox(height: 2),
            Row(
              children: [
                Text(translation(context).withdrawal_date_text + ":", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w400 )),
                Spacer(),
               //duration in format ymd add days based on duration
                Text((DateTime.now().add(Duration(days: days[items.indexOf(selectedvalue!)]))).toString().substring(0,10),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),





              ],
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed:(double.parse(amountControl.text)==0 || double.parse(amountControl.text)>balance)?null: (){

                        double percentaje = percentajes[items.indexOf(selectedvalue)];
                        int duration = days[items.indexOf(selectedvalue!)];
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  StakingStakeView(percentaje: percentaje, duration: duration, amount: amount,)),
                        );
                      },
                      child: Text(translation(context).check_text,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: goldcolor,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        disabledBackgroundColor: Colors.grey,
                      )
                  ),
                ),
              ],
            )


          ],
        ),
      ),
    );
  }




}
