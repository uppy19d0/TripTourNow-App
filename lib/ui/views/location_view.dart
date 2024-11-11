import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/locale_provider.dart';
import '../../router/router.dart';
import '../../theme.dart';

class LocationView extends StatelessWidget {
  const LocationView( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final localesProv = Provider.of<LocaleProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color:Color(0xFF0B0B0B),
          ),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  SizedBox(height:50),
                  Container(
                    width:200,
                    child: Image(image:AssetImage("assets/logo-intro-app.png")),

               ),
                  SizedBox(height:10),

                  SizedBox(height:50),

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: goldcolor,
                      side: BorderSide(color: goldcolor, width: 2), //<-- SEE HERE
                      padding: EdgeInsets.symmetric(vertical:20,horizontal: 40),

                    ),
                    onPressed: () async {
                      localesProv.setLocale(const Locale("en"));
                      Navigator.popAndPushNamed(context, Flurorouter.loginRoute);

                      Navigator.pushReplacementNamed(context, '/login');

                    },
                    child:  Text('ENGLISH' , style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: goldcolor,
                      side: BorderSide(color: goldcolor, width: 2), //<-- SEE HERE
                      padding: EdgeInsets.symmetric(vertical:20,horizontal: 40),
                    ),
                    onPressed: () async {
                      localesProv.setLocale(const Locale("es"));

                      Navigator.popAndPushNamed(context, Flurorouter.loginRoute);

                    },
                    child:  Text('ESPAÑOL' , style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
