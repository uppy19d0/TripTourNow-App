import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/api/HttpApi.dart';

import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';


class StakingStakeView extends StatefulWidget {
  final double percentaje;
  final double amount;
  final int duration;


  const StakingStakeView({Key? key, required this.percentaje, required this.duration, required this.amount}) : super(key: key);

  @override
  State<StakingStakeView> createState() => _StakingStakeViewState();
}

class _StakingStakeViewState extends State<StakingStakeView> {
  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    TextEditingController amountController = TextEditingController(text: '0.0');
//values for dropdown
    //1month, 3months, 6months, 1year
    List<String> items = [
      '1 mes',
      '3 meses',
      '6 meses',
      '1 año',
    ];
    //percentajes linked 1month, 3months, 6months, 1year
    List<double> percentajes = [
      0.15,
      0.20,
      0.25,
      0.30,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(translation(context).confirm_deposit_text, style: TextStyle(color: Colors.white)),
        //icon to go back

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
            //title historial de staking
            SizedBox(height: 20),
            Image.asset('assets/logo-ttc.png',width: 100,height: 100),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(translation(context).deposit_text, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.amount.toStringAsFixed(2), style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(translation(context).earn_text + " "+ (widget.percentaje*100).toString()+"% APR", style: TextStyle(color: thirdColor, fontSize: 16, fontWeight: FontWeight.w400 )),
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Text(translation(context).duration_text + ":", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w400 )),
                Spacer(),
                Text((widget.duration/30).toStringAsFixed(0)+((widget.duration>31) ?' Meses':' Mes'), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 )),

              ],


            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(translation(context).withdrawal_date_text + ":", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w400 )),
                Spacer(),
                //text with date plus duration days
                Text((DateTime.now().add(Duration(days:widget.duration))).toString().substring(0,10),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),

              ],


            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(translation(context).total_profit_text + ":", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w400 )),
                Spacer(),
                //text with date plus duration days
                Text('+ '+((widget.amount*widget.percentaje)).toStringAsFixed(2)+' TTC' ,
                    style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),

              ],


            ),

            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        //flurorouter
                        //NavigationService.navigateTo( Flurorouter.stakingEarnRoute);


                        Map<String, String> nData = {
                          'amount': widget.amount.toString(),
                          'duration': widget.duration.toString(),
                          'percentaje': widget.percentaje.toString(),
                        };

                        //set globaltools loading
                        GlobalTools().showWaitDialog(
                            waitText: translation(context).please_wait);
                        HttpApi.post('/staking', nData).then((value) {
                          if(value['status'] == 'success'){
                            GlobalTools().closeDialog();
                            //Navigator.pushNamed(context, '/success');
                            NavigationService.replaceRemoveTo(
                                Flurorouter.stakingEarnRoute);
                          }

                        }).catchError((error) {
                          GlobalTools().closeDialog();
                          //snackbar error
                          GlobalTools().showSnackBar(
                                message: translation(context).something_wrong_error);

                          print(error);
                          print(error.data);

                        });
                      },
                      child: Text(translation(context).confirm,
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
            ),            //small gold text with alert icon, "el interes se paga al finalizar el periodo, si retira antes no se paga interes y recibira una penalizacion de 25%"

            //wrap the paragraph in a container , add padding and make it mjujltiline
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: greycolor,
              ),
              child: Text(
                translation(context).interest_is_paid_text,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            )



          ],
        ),
      ),
    );
  }

}
