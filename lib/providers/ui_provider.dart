

import 'package:flutter/material.dart';

import '../class/language_constants.dart';
import '../router/router.dart';
import '../services/navigation_service.dart';

class UiProvider  extends ChangeNotifier {

  int _selectedMainMenu = 0;
  int get selectedMainMenu => _selectedMainMenu;
  set selectedMainMenu(int value) {
    _selectedMainMenu = value;
    notifyListeners();
  }
  List<String> pages = [
    Flurorouter.homeRoute,
    Flurorouter.myWalletRoute,//1
    Flurorouter.transactionsRoute,//2
    Flurorouter.offersRoute,//3
    Flurorouter.myAccountRoute,//4
  ];

  String _currentPage = '';
  String get currentPage{
    return _currentPage;
  }

  bool backTickedCore = false;

  void setCurrentPageUrl( String routeName ) {

      //loop in pages ang get index

    _currentPage = routeName;


    Future.delayed(Duration(milliseconds: 200), () {

      checkCurrentPage();
      notifyListeners();

    });
  }

  void checkCurrentPage(){
    if(_currentPage == Flurorouter.homeRoute){
      selectedMainMenu = 0;
    }else if(_currentPage == Flurorouter.myWalletRoute){
      selectedMainMenu = 1;
    }
  }

  bool checkIfCorePages(){
    print("Checking if");
    return _currentPage == Flurorouter.homeRoute ||
        _currentPage == Flurorouter.ticketsRoute ||
        _currentPage == Flurorouter.notificationsRoute;
  }

  String? appBarTitle;
  bool appBarBackBtn = false;
  List<Widget> appBarActions = [];

  void setAppBar({
    String? appBarTitle,
    bool appBarBackBtn = false,
    List<Widget>? appBarActions, bool? backTickedCore}){

    this.appBarTitle = appBarTitle;
    this.appBarBackBtn = appBarBackBtn;
    this.appBarActions = appBarActions ?? [];
    this.backTickedCore = backTickedCore ?? false;
    notifyListeners();
  }

  void bootonNavBarReset(){

  }

  void ticketViewBar(){

    this.appBarTitle = translation(NavigationService.navigatorKey.currentContext!).tickets_title;
    this.appBarBackBtn = true;
    this.appBarActions = [
      Container(
        margin: const EdgeInsets.only(right: 10),
        child: IconButton(
            onPressed: ()=> NavigationService.navigateTo('/tickets/add'),
            icon: Icon(Icons.add, size: 25,)
        ),
      )
    ];
    this.backTickedCore = false;
    notifyListeners();
  }

  void appBarReset(){
    appBarTitle = null;
    appBarBackBtn = false;
    appBarActions = [];
    notifyListeners();
  }

}