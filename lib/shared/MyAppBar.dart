import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';
import '../router/router.dart';
import '../services/navigation_service.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(65);
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final uiProv = Provider.of<UiProvider>(context);

    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      leading: uiProv.appBarBackBtn
          ? BackButton(
              color: Colors.white,
              onPressed: () {
                !uiProv.backTickedCore
                    ? Provider.of<UiProvider>(context, listen: false)
                        .appBarReset()
                    : Provider.of<UiProvider>(context, listen: false)
                        .ticketViewBar();
                Navigator.of(NavigationService.navigatorKey.currentContext!)
                    .pop();
              })
          :
          //home icon
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                NavigationService.replaceRemoveTo(Flurorouter.homeRoute);
              },
            ),
      toolbarHeight: 100,
      backgroundColor: Colors.black,
      actions: [
        IconButton(
          onPressed: () {
            NavigationService.replaceRemoveTo(Flurorouter.notificacionesRoute);
          },
          icon: new Stack(children: <Widget>[
            SvgPicture.asset('assets/icons/notificaciones.svg',
                height: 25, color: Colors.white, semanticsLabel: 'Label'),
            new Positioned(
              // draw a red marble
              top: 0.0,
              left: 0,
              child: new Icon(Icons.brightness_1,
                  size: 8.0, color: Colors.redAccent),
            )
          ]),
        )
      ],
      title: Center(
        child: uiProv.appBarTitle == null
            ? Image.asset(
                'assets/logo-ttc.png',
                height: 35,
              )
            : Text(uiProv.appBarTitle ?? "",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w100)),
      ),
    );
  }
}
