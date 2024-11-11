import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/ui/views/main/ProcessWithdrawal.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/Withdraw.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';

class Withdraws extends StatefulWidget {
  const Withdraws({Key? key}) : super(key: key);

  @override
  State<Withdraws> createState() => _WithdrawsState();
}

class _WithdrawsState extends State<Withdraws> {
  bool isloading= false;
  List<Withdraw> retiros = [];
  @override
  void initState() {
    HttpApi.httpGet('/admin/withdrawals').then((value) {


      //convert value to json
      var data=   value['data'];
      for (var i = 0; i < data.length; i++) {

        Withdraw retiro = Withdraw.fromJson(data[i]);
        retiros.add(retiro);

      }
      //order by date
      retiros.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      print(data);
      setState(() {
        isloading = false;
      });
    }).catchError((error) {
      print(error);
      print(error.data);
    });
  }
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(translation(context).withdrawal_request_text, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
           onPressed: () =>
                NavigationService.replaceRemoveTo(Flurorouter.administracionRoute),
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

        width: double.infinity,
        height: double.infinity,
        child:
            Container(

              child: isloading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                shrinkWrap: true,
                itemCount: retiros.length,
                itemBuilder: (context, index) {
                  return
                    GestureDetector(
                      onTap: () {
                        //navigator.push

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ProcessWithdrawal( retiro: retiros[index])),
                        );

                      },
                      child:Container(
                    color: Colors.black,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(translation(context).user_text + ': ${retiros[index].user_name}',
                                style: TextStyle(color: Colors.white),),
                              Text(translation(context).amount_text + ': ${retiros[index].amount} USD',
                                style: TextStyle(color: Colors.white),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Row(
                                children: [

                                  SizedBox(width: 10,),
                                  //paypal icon
                                  _buildCryptoIcon(retiros[index].mode),
                                ],
                              ),
                              Text( (retiros[index].status == '0') ? translation(context).pending_text : translation(context).approved_text,
                                style: TextStyle(color: (retiros[index].status== '0')? Colors.amberAccent: Colors.green),),
                            ],
                          ),
                          SizedBox(height: 10,),



                        ]),

                      ),
                  );
                })),)
    );
  }
  Widget _buildCryptoIcon(String crypto) {
    Widget result = Container();
    switch (crypto) {
      case 'USDT':
        result= SvgPicture.asset('assets/icons/coin-usdt.svg',
            height: 30, semanticsLabel: 'Label');
        break;
      case 'ETH':
        result= SvgPicture.asset('assets/icons/coin-eth.svg',
            height: 30, semanticsLabel: 'Label');
        break;
      case 'BTC':
        result= SvgPicture.asset('assets/icons/coin-btc.svg',
            height: 30, semanticsLabel: 'Label');
        break;
      default:
        result= SvgPicture.asset('assets/icons/paypal.svg',
            height: 20, semanticsLabel: 'Label');
        break;

    }
    return result;
  }
}
