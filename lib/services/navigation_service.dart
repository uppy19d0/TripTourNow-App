

import 'package:flutter/material.dart';
import 'package:trip_tour_coin/models/Offer.dart';

import '../ui/layouts/core_layaout.dart';

class NavigationService {

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  static navigateTo( String routeName ) {
    return navigatorKey.currentState!.pushNamed( routeName );
  }

  static reloadPage(){
    return navigatorKey.currentState!.pop();
  }

  static replaceTo( String routeName ) {
    return navigatorKey.currentState!.pushReplacementNamed( routeName );
  }

  static replaceRemoveTo( String routeName ) {
    return  navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, ModalRoute.withName(routeName));
  }

  static void pushTo(offerDetailRoute, {required Offer arguments}) {}


}
