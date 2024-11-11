import 'package:flutter/material.dart';

import '../../../class/language_constants.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';

class SuccessExchange extends StatefulWidget {
  const SuccessExchange({Key? key}) : super(key: key);

  @override
  State<SuccessExchange> createState() => _SuccessExchangeState();
}

class _SuccessExchangeState extends State<SuccessExchange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).successful_purchase_text),
        backgroundColor: Colors.black,
      ),
      body:Container(
          width: double.infinity,
          color: backgroundcolor,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child:Column(
              children:[
                //icons.s
                SizedBox(height: 25),
                Image.asset('assets/logo-ttc.png', width: 70, height: 70),
                SizedBox(height: 10),

                SizedBox(height: 30,),
                Text(translation(context).your_order_successful, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),

                SizedBox(height: 20,),
                Text(translation(context).go_to_exchange_house, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                //button
                SizedBox(height: 40,),
                Container(

                  child: ElevatedButton(
                    onPressed: () {
                      //flurorouter
                      NavigationService.replaceRemoveTo(
                          Flurorouter.exchangeIndexRoute);
                    },
                    child: Text(translation(context).continue_text, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40), backgroundColor: goldcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ]
          )
      ),
    );
  }
}
