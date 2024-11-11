import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/ui_provider.dart';
import '../../router/router.dart';
import '../../services/navigation_service.dart';
import '../../shared/BottomNavigation.dart';
import '../../shared/MyAppBar.dart';

class CoreLayout extends StatefulWidget {
  final Widget child;
  const CoreLayout({
    Key? key,
    required this.child
  }) : super(key: key);

  @override
  State<CoreLayout> createState() => _CoreLayoutState();
}

class _CoreLayoutState extends State<CoreLayout> {

  final _navigatorKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }



  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);


    return Scaffold(
      body: Overlay(
        initialEntries: [
          OverlayEntry(
              builder: (context) => Scaffold(
                appBar:  CustomAppBar(

                ),
                body:  widget.child ,
                bottomNavigationBar: MyBottomNavigation(
                    onTap: (int idx) {
                      if (idx == uiProvider.selectedMainMenu) return;
                      uiProvider.selectedMainMenu = idx;
                      uiProvider.appBarReset();
                      NavigationService.navigateTo( uiProvider.pages[uiProvider.selectedMainMenu]);
                    }

                ),
            )
          ),
        ],
      )
    );
  }
}
