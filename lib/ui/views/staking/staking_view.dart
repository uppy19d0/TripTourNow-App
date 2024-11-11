import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/models/Stake.dart';
import 'package:trip_tour_coin/services/navigation_service.dart';
import 'package:trip_tour_coin/theme.dart';
import 'package:trip_tour_coin/ui/views/staking/Staking_details.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/http/error_http.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../shared/BottomNavigation.dart';

class StakingView extends StatefulWidget {
  const StakingView({Key? key}) : super(key: key);

  @override
  State<StakingView> createState() => _StakingViewState();
}

class _StakingViewState extends State<StakingView> {
  double balance = 0.0;
  double staking = 0.0;
  double earnings = 0.0;

  List<Stake> stakingList = [];
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
    HttpApi.httpGet('/staking').then((value) {

      var data=   value['data'];
      for (var i = 0; i < data.length; i++) {
        print(data[i]);
        Stake stk = Stake.fromJson(data[i]);
        stakingList.add(stk);//
      }
      //sum staking and earnings
      double sumStaking = 0.0;
      double sumEarnings = 0.0;
      for (var i = 0; i < stakingList.length; i++) {
        if(stakingList[i].status == 'pending' || stakingList[i].status == 'completed'){
        sumStaking += stakingList[i].amount;
        sumEarnings += stakingList[i].amount * stakingList[i].percentage;
        }
      }
      setState(() {
        staking = sumStaking;
        earnings = sumEarnings;
        print(value);
      });
      //PR

    }).catchError((error) {
      //if error is ErrorHttp
      print(error);
      if (error is ErrorHttp) {
        print(error.data);
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

    //scaffold, appbar black with ttc icon on the center and a button to go to the staking page
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Staking'),
        //icon to go back
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => { NavigationService.replaceRemoveTo(Flurorouter.homeRoute)}),
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

            Text(
              translation(context).my_summary_text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Montserrat',
              ),
            ),


        Divider(color: Colors.white),
            BalanceWidget(),
            SizedBox(height: 20),
            HistoryWidget(),
          ],
        ),
      ),
    );
  }

  Widget HistoryWidget() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        decoration: BoxDecoration(),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: (){
                      //flurorouter
                      NavigationService.navigateTo( Flurorouter.stakingDepositarRoute);
                    },
                    child: Text(translation(context).deposit_text,
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
              )
            ],
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translation(context).my_deposits_text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
          Divider(color: Colors.white),
          SizedBox(height: 10),
          //make a listview with the staking entries
          (stakingList.length == 0)
              ? Text(translation(context).no_deposits_text, style: TextStyle(color: Colors.white))
              : ListView.builder(
            //no scroll
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: stakingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return StakingEntry( stakingList[index]);
                  }),



        ]));
  }

  Widget StakingEntry(Stake aux) {
    return
      GestureDetector(

        onTap: (){
            //navigator.push
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  StakingDetails(stake : aux )),
          );

        },
          child:Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: EdgeInsets.symmetric(vertical: 10),

        child: Column(children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //ttc icon
              Row(
                children: [
                  Image.asset(
                    'assets/logo-ttc.png',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 5),
                  Text('TTC (TRIP TOUR COIN)',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
              SizedBox(width: 5),
              Text((aux.duration/30).toStringAsFixed(0)+((aux.duration>31) ?' Meses':' Mes'), style: TextStyle(color: goldcolor, fontSize: 14)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            //row with monto, porcentaje y monto acumulado
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    translation(context).amount_text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    aux.amount.toStringAsFixed(0)+' TTC'  ,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    translation(context).percentaje_text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    (aux.percentage*100).toStringAsFixed(0)+'%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    translation(context).profit_text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    (aux.percentage* aux.amount).toStringAsFixed(0)+' TTC',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
        ])));
  }

  Widget BalanceWidget() {
    //background black , color white
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Balance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/logo-ttc.png',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    balance.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Staking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                ),
              ),
              //balance with icon ttc as prefix
              Row(
                children: [
                  Image.asset(
                    'assets/logo-ttc.png',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    staking.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Capital',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/logo-ttc.png',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    (balance+staking).toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translation(context).profits_text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/logo-ttc.png',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 5),
                  Text(
                    earnings.toDouble().toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),

          Row(
            //make 2 boxes , earned in the last 30 days and erned today
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      translation(context).thirty_days_profit_text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(
                          'assets/logo-ttc.png',
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '+ ' + '0.1',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      translation(context).earnt_todat_text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(
                          'assets/logo-ttc.png',
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '+ ' + '0.0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}
