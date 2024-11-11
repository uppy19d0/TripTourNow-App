import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/router/router.dart';
import 'package:trip_tour_coin/theme.dart';
import 'package:trip_tour_coin/ui/layouts/core_layaout.dart';
import 'package:trip_tour_coin/ui/views/main/BuyWithPaypal.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../services/navigation_service.dart';
import 'BuyWithBank.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  double balance = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    HttpApi.httpGet('/user/balance').then((value) {
      print(value);

      setState(() {
        balance = value['balance'].toDouble();
      });

      print(balance);

    }).catchError((error) {
      print(error);

    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var btnfs  = 14.0;
    double iconsize = 10 ;
    double btnpadding= 10;
    // 1 is the index of My Wallet
    double buybtnfs =14;
    return CoreLayout(
      child: Container(
        color: backgroundcolor,
        child: ListView(
          children: [
            //golden container with the balance
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              color: lightgold,
              child: Column(
                children: [
                  //Row for ICon, Coin Name and Balance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Image logo-ttc.png
                      Row(
                        children: [
                          Image.asset(
                            'assets/logo-ttc.png',
                            height: 50,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Trip Tour Now',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Saldo Disponible',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),

                      //Balance
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            balance.toStringAsFixed(2) + ' USD',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  //row with 3 outlined buttons for send , receive and buy
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // 2 is the index of Buy
                          NavigationService.replaceRemoveTo(Flurorouter.enviarRoute);

                          //
                        },
                        child:
                      Container(
                        height: 40,
                        padding:
                            EdgeInsets.symmetric(horizontal: btnpadding, vertical: 10),

                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        //'enviar' + paper plane icon
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translation(context).send_text,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: btnfs,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            //svg icon
                            SvgPicture.asset('assets/icons/enviar-negro.svg',
                                height: iconsize.ceilToDouble(),
                                color: Colors.black,
                                semanticsLabel: 'Label')
                          ],
                        ),
                      ),),
                      GestureDetector(
                        onTap: () {
                          // 2 is the index of Buy
                          print('');
                          NavigationService.replaceRemoveTo(Flurorouter.recibirRoute);

                          //
                        },
                        child:
                      Container(
                        height: 40,
                        padding:
                            EdgeInsets.symmetric(horizontal: btnpadding, vertical: 10),

                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        //'enviar' + paper plane icon
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translation(context).receive_text,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: btnfs,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            //svg icon
                            SvgPicture.asset('assets/icons/recibir-negro.svg',
                                height: iconsize,
                                color: Colors.black,
                                semanticsLabel: 'Label'),
                          ],
                        ),
                      ),),
                      GestureDetector(
                        onTap: () {
                          // 2 is the index of Buy
                        print('comprar');
                        NavigationService.replaceRemoveTo(Flurorouter.comprarRoute);

                            //
                        },
                        child:
                      Container(
                        height: 40,
                        padding:
                            EdgeInsets.symmetric(horizontal:btnpadding, vertical: btnpadding),

                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        //'enviar' + paper plane icon
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translation(context).buy_text,
                              style: TextStyle(
                                  color: goldcolor,
                                  fontSize: btnfs,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            //svg icon
                            SvgPicture.asset('assets/icons/comprar-dorado.svg',
                                height: iconsize+5  ,
                                color: goldcolor,
                                semanticsLabel: 'Label')
                          ],
                        ),
                      ),
                      )//recibir
                    ],
                  ),
                  //paragraph
                ],
              ),
            ),

            SizedBox(
              height: 0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Text(
                translation(context).buy_ttc_text,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            //make a black container

          /*
            Container(
                color: Colors.black,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child:
                    Row(
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
                          height: 40,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),

                          decoration: BoxDecoration(

                            border: Border.all(color: goldcolor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          //'enviar' + paper plane icon
                          child: GestureDetector(
                            onTap: () {
                              NavigationService.replaceRemoveTo(
                                  Flurorouter.buywithbtcRoute);
                            },

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translation(context).buy_text + ' TTC',
                                  style: TextStyle(
                                      color: goldcolor,
                                      fontSize: buybtnfs,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                //svg icon
                                SvgPicture.asset(
                                    'assets/icons/comprar-dorado.svg',
                                    height: 15,
                                    color: goldcolor,
                                    semanticsLabel: 'Label')
                              ],
                            ),
                          ),),
                      ],

                )),
           Container(
                color: Colors.black,
                margin: EdgeInsets.only(bottom: 0, left: 20, right:20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child:
                Row(
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
                      height: 40,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),

                      decoration: BoxDecoration(

                        border: Border.all(color: goldcolor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      //'enviar' + paper plane icon
                      child: GestureDetector(
                        onTap: () {
                          //exchangehandler
                          // 2 is the index of Buy
                          NavigationService.replaceRemoveTo(
                              Flurorouter.buywithethRoute);

                          //
                        },

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translation(context).buy_text + ' TTC',
                              style: TextStyle(
                                  color: goldcolor,
                                  fontSize: buybtnfs,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            //svg icon
                            SvgPicture.asset(
                                'assets/icons/comprar-dorado.svg',
                                height: 15,
                                color: goldcolor,
                                semanticsLabel: 'Label')
                          ],
                        ),
                      ),),
                  ],

                )),
*/
/*
            SizedBox(height: 20,),
            Container(
                color: Colors.black,
                margin: EdgeInsets.only(bottom: 0, left: 20, right:20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child:
                Row(
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
                      height: 40,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),

                      decoration: BoxDecoration(

                        border: Border.all(color: goldcolor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      //'enviar' + paper plane icon
                      child: GestureDetector(
                        onTap: () {
                         //exchangehandler
                          // 2 is the index of Buy
                          NavigationService.replaceRemoveTo(
                              Flurorouter.buywithusdtRoute);

                          //
                        },

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translation(context).buy_text + ' TTC',
                              style: TextStyle(
                                  color: goldcolor,
                                  fontSize: buybtnfs,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            //svg icon
                            SvgPicture.asset(
                                'assets/icons/comprar-dorado.svg',
                                height: 15,
                                color: goldcolor,
                                semanticsLabel: 'Label')
                          ],
                        ),
                      ),),
                  ],

                )),
                */
            Container(
                color: Colors.black,
                margin: EdgeInsets.only(bottom: 20, left: 20, right:20,top: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child:

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    //svg icon

                    Row(

                      children: [
                        SvgPicture.asset('assets/icons/paypal.svg',
                            width: 80, semanticsLabel: 'Label'),
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
                      height: 40,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),

                      decoration: BoxDecoration(

                        border: Border.all(color: goldcolor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      //'enviar' + paper plane icon
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BuyWithPaypal()),
                          );
                        },

                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            translation(context).buy_text + '',
                            style: TextStyle(
                                color: goldcolor,
                                fontSize: buybtnfs,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          //svg icon
                          SvgPicture.asset(
                              'assets/icons/comprar-dorado.svg',
                              height: 15,
                              color: goldcolor,
                              semanticsLabel: 'Label')
                        ],
                      ),
                    ),),
                  ],

                )),
            /*
            //label Transferencias bancarias
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                translation(context).bank_transfers_text,
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                color: Colors.black,
                margin: EdgeInsets.only(bottom: 20, left: 20, right:20,top: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child:

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    //svg icon
                    Row(

                      children: [
                        //logobhdleon.png
                        Image.asset(
                          'assets/logobhdleon.png',
                          //width half of screen size
                          width: MediaQuery.of(context).size.width/3,
                        ),
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
                      height: 40,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),

                      decoration: BoxDecoration(

                        border: Border.all(color: goldcolor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      //'enviar' + paper plane icon
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BuyWithBank()),
                          );
                        },

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translation(context).buy_text + ' TTC',
                              style: TextStyle(
                                  color: goldcolor,
                                  fontSize: buybtnfs,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            //svg icon
                            SvgPicture.asset(
                                'assets/icons/comprar-dorado.svg',
                                height: 15,
                                color: goldcolor,
                                semanticsLabel: 'Label')
                          ],
                        ),
                      ),),
                  ],

                )),*/
          ],
        ),
      ),
    );
  }
}
