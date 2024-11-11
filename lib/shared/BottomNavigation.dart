
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as Bd;
import '../class/language_constants.dart';
import '../providers/auth_provider.dart';
import '../providers/ui_provider.dart';
import '../theme.dart';



class MyBottomNavigation extends StatefulWidget {
  final Function(int index) onTap;


  MyBottomNavigation({required this.onTap });

  @override
  _MyBottomNavigationState createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {


  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    return BottomNavigationBar(
      unselectedLabelStyle:  TextStyle(fontFamily: "Gotham",color: Colors.white),
      selectedLabelStyle: TextStyle( fontFamily: "Gotham", fontSize: 12,color:goldcolor),
      type: BottomNavigationBarType.fixed, // Fixed
      backgroundColor: Colors.black,

      unselectedItemColor: Colors.white,
      selectedItemColor: goldcolor,
      //selectedItemColor: Color(0xFFc5965f),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      onTap: widget.onTap,
      currentIndex: uiProvider.selectedMainMenu,
      items: [
        BottomNavigationBarItem(
          label: 'Inicio',
          activeIcon: Container(
            padding: EdgeInsets.only(bottom: 5),
            child:     SvgPicture.asset(
                'assets/icons/menu-inicio.svg',
                height: 20,
                color: goldcolor,
                semanticsLabel: 'Label'
            ),
          ),
          icon: Container(
            padding: EdgeInsets.only(bottom: 5),
            child:  SvgPicture.asset(
                'assets/icons/menu-inicio.svg',
                height: 20,
                color: white,
                semanticsLabel: 'Label'
            ),
          ),
        ),

        BottomNavigationBarItem(
          label: "Mi cartera",
          activeIcon: Container(
            padding: EdgeInsets.only(bottom: 5),
            child:  SvgPicture.asset(
                'assets/icons/menu-cartera.svg',
                height: 20,
                color: goldcolor,
                semanticsLabel: 'Label'
            ),
          ),
          icon: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(
                'assets/icons/menu-cartera.svg',
                height: 20,
                color: white,
                semanticsLabel: 'Label'
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "Historial",
          activeIcon: SvgPicture.asset(
              'assets/icons/menu-transacciones.svg',
              height: 20,
              color:goldcolor,
              semanticsLabel: 'Label'
          ),
          icon: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(
                'assets/icons/menu-transacciones.svg',
                height: 20,
                color: white,
                semanticsLabel: 'Label'
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "Ofertas",
          activeIcon: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(
                'assets/icons/menu-ofertas'
                    '.svg',
                height: 20,
                color: goldcolor,
                semanticsLabel: 'Label'
            ),
          ),
          icon: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(
                'assets/icons/menu-ofertas.svg',
                height: 20,
                color: white,
                semanticsLabel: 'Label'
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "Mi cuenta",
          activeIcon: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(
                'assets/icons/micuenta-perfil.svg',
                height: 20,
                color: goldcolor,
                semanticsLabel: 'Label'
            ),
          ),
          icon: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: SvgPicture.asset(
                'assets/icons/micuenta-perfil.svg',
                height: 20,
                color: white,
                semanticsLabel: 'Label'
            ),
          ),
        ),

      ],
    );
  }
}
