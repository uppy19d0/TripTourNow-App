

import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/providers/auth_provider.dart';
import 'package:trip_tour_coin/ui/views/staking/staking_stake_view.dart';

import '../ui/views/login_view.dart';
import '../ui/views/staking/StakingCancelled.dart';
import '../ui/views/staking/staking_earn_view.dart';
import '../ui/views/staking/staking_input_view.dart';

class StakingHandlers {
  //staking
  static Handler stakingDeposit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return StakingInputView();
  });

  static Handler stakingStake = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();

  });


  static Handler earnStake = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    print("earnStake");
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return StakingEarnView();
  });

//StakingCancelled
 static Handler stakingCancelled = Handler(handlerFunc: (context, params) {
      final authProvider = Provider.of<AuthProvider>(context!);

      if (authProvider.authStatus == AuthStatus.notAuthenticated)
        return LoginView();
      else
        return StakingCancelled();
    });






}