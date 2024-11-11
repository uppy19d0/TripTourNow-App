import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/Offer.dart';
import '../../../models/Transaction.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';
import '../../layouts/core_layaout.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<Transaction> transactions = [];
  List<Offer> ofertas = [];
  bool isloading = false;
  String master =
      'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855';
  @override
  void initState() {
    //call route user/transactions
    setState(() {
      isloading = true;
    });
    HttpApi.httpGet('/admin/posts').then((value) {
      print(value);

      //convert value to json
      var data = value['data'];
      for (var i = 0; i < data.length; i++) {
        print(data[i]);
        Offer offer = Offer.fromJson(data[i]);
        ofertas.add(offer); //
      }
      HttpApi.httpGet('/user/transactions').then((value) {
        //iterate over the value['transactions'] and add to the list
        var data = value['transactions'];
        print(data);
        for (var i = 0; i < data.length; i++) {
          print(data[i]);
          Transaction t = Transaction.fromJson(data[i]);
          transactions.add(t);
        }
        setState(() {
          isloading = false;
        });
      }).catchError((error) {
        setState(() {
          isloading = false;
        });
        print(error);
        print(error.data);
      });

    }).catchError((error) {
      print(error);
      print(error.data);
    });


    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).transaction_history_text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w100),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
          onPressed: () {
            NavigationService.replaceRemoveTo(
                Flurorouter.homeRoute);
          },
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo(
            uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      //add floating action button

      body: (isloading )
          ? Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(
                  color: goldcolor,
                  backgroundColor: Colors.black,
                ),
              ))
          : Container(
              color: backgroundcolor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView(
                children: [
                  //listview

                  if (transactions.length == 0)
                    Center(
                      child: Text(
                        translation(context).no_transactions_to_show_text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  else
                    isloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              if (transactions[index].type == 'addFunds') {
                                return Container(
                                  child: ListTile(
                                    dense: true,
                                    visualDensity: VisualDensity(vertical: 2), // to expand
                                    leading: SvgPicture.asset(
                                        'assets/icons/trans-compra-ttc.svg',
                                        height: 30,
                                        semanticsLabel: 'Label'),
                                    title: Text(
                                      translation(context).buy_text + '',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //subtitle is the created_at dateformat dd/mm/yyyy
                                    subtitle: Text(
                                      transactions[index]
                                              .createdAt
                                              .day
                                              .toString() +
                                          '/' +
                                          transactions[index]
                                              .createdAt
                                              .month
                                              .toString() +
                                          '/' +
                                          transactions[index]
                                              .createdAt
                                              .year
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          transactions[index]
                                              .amount
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'TTC',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        //if pending show pending in red, if completed show completed in green
                                        Text(
                                          transactions[index].status ==
                                                  'pending'
                                              ? translation(context).pending_text
                                              : translation(context).completed_text,
                                          style: TextStyle(
                                              color:
                                                  transactions[index].status ==
                                                          'pending'
                                                      ? Colors.red
                                                      : Colors.green,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (transactions[index].type ==
                                  'buyPost') {
                                print('buy post');
                                print(transactions[index].offerId);
                                Offer offer = ofertas.firstWhere((element) =>
                                    element.id == transactions[index].offerId);


                                return Container(
                                  child: ListTile(
                                    dense: true,
                                    visualDensity: VisualDensity(vertical: 2), //
                                    leading: SvgPicture.asset(
                                        'assets/icons/trans-compra-oferta.svg',
                                        height: 30,
                                        semanticsLabel: 'Label'),
                                    title: Text(
                                      translation(context).purchase_offer_text,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //subtitle is the created_at dateformat dd/mm/yyyy
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          offer.title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          transactions[index]
                                                  .createdAt
                                                  .day
                                                  .toString() +
                                              '/' +
                                              transactions[index]
                                                  .createdAt
                                                  .month
                                                  .toString() +
                                              '/' +
                                              transactions[index]
                                                  .createdAt
                                                  .year
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          transactions[index]
                                              .amount
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'USD',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        //if pending show pending in red, if completed show completed in green
                                        Text(
                                          transactions[index].status ==
                                                  'pending'
                                              ? translation(context).pending_text
                                              : translation(context).completed_text,
                                          style: TextStyle(
                                              color:
                                                  transactions[index].status ==
                                                          'pending'
                                                      ? Colors.red
                                                      : Colors.green,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              else  if (transactions[index].type == 'staking') {
                                return Container(
                                  child: ListTile(
                                    dense: true,
                                    visualDensity: VisualDensity(vertical: 2), //
                                    leading:   Image.asset(
                                      'assets/icons/moni.png',
                                      height: 30,
                                    ),
                                    title: Text(
                                      'Staking USD',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //subtitle is the created_at dateformat dd/mm/yyyy
                                    subtitle: Text(
                                      transactions[index]
                                          .createdAt
                                          .day
                                          .toString() +
                                          '/' +
                                          transactions[index]
                                              .createdAt
                                              .month
                                              .toString() +
                                          '/' +
                                          transactions[index]
                                              .createdAt
                                              .year
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          transactions[index]
                                              .amount
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'USD',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        //if pending show pending in red, if completed show completed in green
                                        Text(
                                          transactions[index].status ==
                                              'pending'
                                              ? translation(context).pending_text
                                              : translation(context).completed_text,
                                          style: TextStyle(
                                              color:
                                              transactions[index].status ==
                                                  'pending'
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              else if (transactions[index].type == 'withdraw') {
                                return Container(
                                  child: ListTile(
                                    dense: true,
                                    visualDensity: VisualDensity(vertical: 2), //
                                    leading: Image.asset(
                                      'assets/icons/withdraw.png',
                                      height: 30,
                                    ),
                                    title: Text(
                                      translation(context).ttc_withdrawal_text,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //subtitle is the created_at dateformat dd/mm/yyyy
                                    subtitle: Text(
                                      transactions[index]
                                          .createdAt
                                          .day
                                          .toString() +
                                          '/' +
                                          transactions[index]
                                              .createdAt
                                              .month
                                              .toString() +
                                          '/' +
                                          transactions[index]
                                              .createdAt
                                              .year
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          transactions[index]
                                              .amount
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'USD',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        //if pending show pending in red, if completed show completed in green
                                        Text(
                                          transactions[index].status ==
                                              'pending'
                                              ? translation(context).pending_text
                                              : translation(context).completed_text,
                                          style: TextStyle(
                                              color:
                                              transactions[index].status ==
                                                  'pending'
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              else if (transactions[index].type == 'exchange') {
                                return Container(
                                  child: ListTile(
                                    dense: true,
                                    visualDensity: VisualDensity(vertical: 2), //
                                    leading: Icon(
                                      FontAwesomeIcons.buildingColumns,
                                      color: goldcolor,
                                      size: 22,
                                    ),
                                    title: Text(
                                      translation(context).currency_exchange_text,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //subtitle is the created_at dateformat dd/mm/yyyy
                                    subtitle: Text(
                                      transactions[index]
                                          .createdAt
                                          .day
                                          .toString() +
                                          '/' +
                                          transactions[index]
                                              .createdAt
                                              .month
                                              .toString() +
                                          '/' +
                                          transactions[index]
                                              .createdAt
                                              .year
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          transactions[index]
                                              .amount
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'USD',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        //if pending show pending in red, if completed show completed in green
                                        Text(
                                          transactions[index].status ==
                                              'pending'
                                              ? translation(context).pending_text
                                              : translation(context).completed_text,
                                          style: TextStyle(
                                              color:
                                              transactions[index].status ==
                                                  'pending'
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              else if (transactions[index].type ==
                                  'moneySend') {
                                if (authProv.user!.address ==
                                    transactions[index].sender) {
                                  return Container(
                                    child: ListTile(
                                      dense: true,
                                      visualDensity: VisualDensity(vertical: 2), //
                                      leading: SvgPicture.asset(
                                          'assets/icons/trans-envio.svg',
                                          height: 30,
                                          semanticsLabel: 'Label'),
                                      title: Text(
                                        translation(context).ttc_shipping_text,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //subtitle is the created_at dateformat dd/mm/yyyy
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transactions[index]
                                                    .createdAt
                                                    .day
                                                    .toString() +
                                                '/' +
                                                transactions[index]
                                                    .createdAt
                                                    .month
                                                    .toString() +
                                                '/' +
                                                transactions[index]
                                                    .createdAt
                                                    .year
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            transactions[index]
                                                .amount
                                                .toStringAsFixed(2),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'USD',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          //if pending show pending in red, if completed show completed in green
                                          Text(
                                            transactions[index].status ==
                                                    'pending'
                                                ? translation(context).pending_text
                                                : translation(context).completed_text,
                                            style: TextStyle(
                                                color: transactions[index]
                                                            .status ==
                                                        'pending'
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                if (authProv.user!.address ==
                                    transactions[index].receiver) {
                                  return Container(
                                    child: ListTile(
                                      dense: true,
                                      visualDensity: VisualDensity(vertical: 2), //
                                      leading: SvgPicture.asset(
                                          'assets/icons/trans-recepcion.svg',
                                          height: 30,
                                          semanticsLabel: 'Label'),
                                      title: Text(
                                        translation(context).ttc_reception_text,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //subtitle is the created_at dateformat dd/mm/yyyy
                                      subtitle: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transactions[index]
                                                .createdAt
                                                .day
                                                .toString() +
                                                '/' +
                                                transactions[index]
                                                    .createdAt
                                                    .month
                                                    .toString() +
                                                '/' +
                                                transactions[index]
                                                    .createdAt
                                                    .year
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            transactions[index]
                                                .amount
                                                .toStringAsFixed(2),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'USD',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          //if pending show pending in red, if completed show completed in green
                                          Text(
                                            transactions[index].status ==
                                                'pending'
                                                ? translation(context).pending_text
                                                : translation(context).completed_text,
                                            style: TextStyle(
                                                color: transactions[index]
                                                    .status ==
                                                    'pending'
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                              } else {
                                return Container(
                                    child: Text(transactions[index].type));
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                color: Colors.white,
                              );
                            },
                          )
                ],
              )),
    );
  }
}
