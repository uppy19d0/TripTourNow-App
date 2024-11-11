import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/api/HttpApi.dart';
import 'package:trip_tour_coin/models/Stake.dart';

import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';

class StakingDetails extends StatefulWidget {
  final Stake stake;

  const StakingDetails({Key? key, required this.stake}) : super(key: key);

  @override
  State<StakingDetails> createState() => _StakingDetailsState();
}

class _StakingDetailsState extends State<StakingDetails> {
  double staking = 0.0;
  double ganancia = 0.0;
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(translation(context).staking_details_text, style: TextStyle(color: Colors.white)),
        //icon to go back

      ),

      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo( uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      body: Container(
        color: backgroundcolor,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            //title historial de staking
            SizedBox(height: 15),
            Image.asset('assets/logo-ttc.png',width: 100,height: 100),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.stake.amount.toStringAsFixed(2)+ ' TTC', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold )),
              ],
            ),


            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translation(context).percentaje_text, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),
                Text((widget.stake.percentage*100).toStringAsFixed(2)+ '%', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),


              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translation(context).start_date_text, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),
                //crreated at
                Text(widget.stake.createdAt.toString().substring(0,10), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),


              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translation(context).payment_date_text, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),
                //crreated at
                Text(widget.stake.endDate.toString().substring(0,10), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),

]
            ),
SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translation(context).status_text, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),
                //crreated at
                if(widget.stake.status == 'pending')
                  Text('Activo', style: TextStyle(color: goldcolor, fontSize: 16, fontWeight: FontWeight.w400 )),
                if(widget.stake.status == 'completed')
                  Text(translation(context).completed_text, style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w400 )),
                if(widget.stake.status == 'cancelled')
                  Text(translation(context).cancelled_text, style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w400 )),
                ]),
            SizedBox(height: 20),
            //recompensa total acumulada
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translation(context).accumulated_reward_text, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),
                //crreated at

                Text('+ '+ calculaterewards(widget.stake), style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w400 )),

              ],
            ),
            //Total a recibir al finalizar el staking
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translation(context).total_to_receive_text, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400 )),
                //crreated at
                Text((widget.stake.amount * widget.stake.percentage).toStringAsFixed(2), style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400 )),

              ],
            ),
            //golden button reembolsar
            SizedBox(height: 40),
      if(widget.stake.status == 'pending')
      Container(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {


            //open confirmation dialog, background black, and text "al reembolsar se perderan las recompensas acumuladas, ademas recibira una penalizacion de 25% sobre su dinero depositado, desea continuar?
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.black,
                    title: Text(translation(context).want_continue_text, style: TextStyle(color: Colors.white)),
                    content: Text(translation(context).want_to_refund_text, style: TextStyle(color: Colors.white)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();

                        },
                        child: Text(translation(context).cancel_text, style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          GlobalTools().showWaitDialog(
                              waitText: translation(context).please_wait);
                          print('se manda');

                          HttpApi.post('/staking/cancel', {'id': widget.stake.id}).then((value) {
                            GlobalTools().closeDialog();

                            print(value);

                            if (value['status'] == 'success') {
                              print('eureka');
                              NavigationService.replaceRemoveTo(
                                  Flurorouter.confirmationRoute);
                            } else {
                            }
                          }).catchError((onError) {
                            print(onError);

                            GlobalTools().closeDialog();
                          });
                        },
                        child: Text(translation(context).refund_text, style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  );
                });
          },
          child: Text(translation(context).refund_text, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600 )),
          style: ElevatedButton.styleFrom(
            backgroundColor: goldcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // <-- Radius
            ),
          ),
        ),
      )


          ],
        ),
      ),
    );
  }

  String calculaterewards(Stake stake) {

    if(stake.status == 'completed'){
      return (stake.amount * stake.percentage).toStringAsFixed(2);
    }else if(stake.status == 'cancelled'){
      return '0.00';
    }

    DateTime now = DateTime.now();
    DateTime end = stake.endDate;
    DateTime start = stake.createdAt;
    double rewards = 0;
    int days = now.difference(start).inDays;
    double total = stake.amount * stake.percentage;
    double daily = total / stake.duration;
    rewards = daily * days;


//get the number of days passed

    return rewards.toStringAsFixed(2);
  }
}
