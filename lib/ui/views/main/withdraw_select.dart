import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/theme.dart';
import 'package:trip_tour_coin/ui/layouts/core_layaout.dart';
import 'package:trip_tour_coin/ui/views/main/withdrawWithBank.dart';
import 'package:trip_tour_coin/ui/views/main/withdrawWithCrypto.dart';

import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';

class Withdraw_method_page extends StatefulWidget {
  const Withdraw_method_page({Key? key}) : super(key: key);

  @override
  State<Withdraw_method_page> createState() => _Withdraw_method_pageState();
}

class _Withdraw_method_pageState extends State<Withdraw_method_page> {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          //back button to go back to offers list
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              NavigationService.replaceRemoveTo(Flurorouter.withdrawsRoute);
            },
          ),
          title: Text(
            translation(context).withdraw_funds_text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w100),
          ),
          backgroundColor: Colors.black,
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
            height: double.infinity,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                SizedBox(
                  height: 30,
                ),

                Container(
                  child: Text(
                    translation(context).select_withdrawal_method_text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                //puedes retirar tu saldo ttc a tus cuentas bancarias y monederos
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    translation(context).you_can_withdraw_text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w100),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //listTile with payment method Paypal
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/withdraw_paypal');
                  },
                  child: Container(
                      color: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //svg icon
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/paypal.svg',
                                  width: 100, semanticsLabel: 'Label'),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          //button to buy
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translation(context).more_than_text + " \$15",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '2.00% + 0.40 USD',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                 //navigator push view, WithdrawWithCrypto
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WithdrawWithCrypto(
                        option: 'USDT',
                      )),
                    );

                  },
                  child: Container(
                      color: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //svg icon
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/coin-usdt.svg',
                                  height: 40, semanticsLabel: 'Label'),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'USDT',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Tether',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //button to buy
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translation(context).more_than_text + " \$15",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '2.00% + 0.40 USD',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                //BTC
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WithdrawWithCrypto( option: 'BTC',)),
                    );
                  },
                  child: Container(
                      color: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //svg icon
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/coin-btc.svg',
                                  height: 40, semanticsLabel: 'Label'),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'BTC',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Bitcoin',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //button to buy
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translation(context).more_than_text + " \$15",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '2.00% + 0.40 USD',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WithdrawWithCrypto( option: 'ETH',)),
                    );
                  },
                  child: Container(
                      color: Colors.black,
                      padding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //svg icon
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/coin-eth.svg',
                                  height: 40, semanticsLabel: 'Label'),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ETH',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Ethereum',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //button to buy
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translation(context).more_than_text + " \$15",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '2.00% + 0.40 USD',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),

                //retiros a cuentas bancarias
                SizedBox(
                  height: 20,
                ),


              ],
            )));
  }
}
