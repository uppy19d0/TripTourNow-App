import 'package:flutter/material.dart';

import '../../../class/language_constants.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';

class OfferConfirmation extends StatefulWidget {
  const OfferConfirmation({Key? key}) : super(key: key);

  @override
  State<OfferConfirmation> createState() => _OfferConfirmationState();
}

class _OfferConfirmationState extends State<OfferConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).success_text),
        backgroundColor: Colors.black,
      ),
      body:Container(
          width: double.infinity,
          color: backgroundcolor,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child:Column(
              children:[
                SizedBox(height: 40,),
                //icons.s
                Icon(Icons.check_circle, color:goldcolor, size: 100,),

                SizedBox(height: 30,),
                Text(translation(context).offer_created_success_text, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, ),textAlign: TextAlign.center,),

                SizedBox(height: 20,),
                Text(translation(context).however_team_must_validate_text, style: TextStyle(color: Colors.white, fontSize: 12, ),textAlign: TextAlign.center,),
                //button
                SizedBox(height: 40,),
                Container(

                  child: ElevatedButton(
                    onPressed: () {
                      //flurorouter
                      NavigationService.replaceRemoveTo(
                          Flurorouter.backofficeListOffersRoute);
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
