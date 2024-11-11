import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/providers/auth_provider.dart';
import 'package:trip_tour_coin/ui/views/exchange/Indexexchange.dart';
import 'package:trip_tour_coin/ui/views/main/BuyWithPaypal.dart';
import 'package:trip_tour_coin/ui/views/staking/staking_stake_view.dart';

import '../ui/views/exchange/AddExchange.dart';
import '../ui/views/exchange/SuccessExchange.dart';
import '../ui/views/login_view.dart';
import '../ui/views/main/BuyWithBtcView.dart';
import '../ui/views/main/BuyWithEthView.dart';
import '../ui/views/main/BuyWithUsdView.dart';
import '../ui/views/main/ReconciliationConfirm.dart';
import '../ui/views/main/conciliations.dart';

class ExchangeHandlers {
  //detailsConciliation

  //buy with btc
  static Handler buywithbtc = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return BuyWithBtcView();

  });
  //buywitheth
  static Handler buywitheth = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return BuyWithEthView();
  });
  //buy with usdt
  static Handler buywithusdt = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return BuyWithUsdtView();
  });
  //conciliations
  static Handler conciliations = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return ConciliationsView();
  });
  //ReconciliationConfirm
  static Handler reconciliationConfirm = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return ReconciliationConfirm();
  });
  //ExchangeIndex
  static Handler exchangeIndex = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return ExchangeIndex();
  });
  //ExchangeAdd
  static Handler exchangeAdd = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return AddExchange();
  });
  //successExchange
  static Handler successExchange = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return SuccessExchange();
  });
//buywithpaypal
  static Handler buywithpaypal = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return BuyWithPaypal();
  });
  //buywithpaypalsuccess
  static Handler buywithpaypalsuccess = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();

  });

}