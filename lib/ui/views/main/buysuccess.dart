import 'package:flutter/material.dart';

import '../../../class/language_constants.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';

class BuySuccess extends StatelessWidget {
  const BuySuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Compra exitosa'),
          backgroundColor: Colors.black,
        ),
      body:Container(
          width: double.infinity,
          color: backgroundcolor,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child:Column(
              children:[
                //icons.s
                Icon(Icons.check_circle, color:goldcolor, size: 100,),

                SizedBox(height: 30,),
                Text(translation(context).successful_purchase_text, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),

                SizedBox(height: 20,),
                Text(translation(context).may_take_time_text, style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                //button
                SizedBox(height: 40,),
                Container(

                  child: ElevatedButton(
                    onPressed: () {
                      //flurorouter
                      NavigationService.replaceRemoveTo(
                          Flurorouter.homeRoute);
                    },
                    child: Text(translation(context).back_main_menu_text, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
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
