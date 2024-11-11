import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/theme.dart';

import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../widgets/button_widget/primary_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Administracion extends StatefulWidget {
  const Administracion({Key? key}) : super(key: key);

  @override
  State<Administracion> createState() => _AdministracionState();
}

class _AdministracionState extends State<Administracion> {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).administration_text),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () =>
              NavigationService.replaceRemoveTo(Flurorouter.homeRoute),
        ),

      ),
      bottomNavigationBar: MyBottomNavigation(
          onTap: (int idx) {
            if (idx == uiProvider.selectedMainMenu) return;
            uiProvider.selectedMainMenu = idx;
            uiProvider.appBarReset();
            NavigationService.navigateTo( uiProvider.pages[uiProvider.selectedMainMenu]);
          }

      ),
      body: Container(
        color: backgroundcolor,
        height  : double.infinity,
        width: double.infinity,

        child:ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          children: [
            Container(
              child: Menu(),

            ),
            SizedBox(height: 20),
            PrimaryButtonWidget(text: translation(context).mine_new_block, onPressed: (){
              //get http://3.15.240.116/mine_block
              /*/http.get(Uri.parse('http://3.15.240.116/mine_block')).then((value) {
                print(value.body);
                var data = jsonDecode(value.body);
                print(data['message']);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
              });*/
              //use the code commented above to send the request but use try catch to catch the error and also show snackbar.
              try{
                //show loading

                http.get(Uri.parse('http://3.15.240.116/mine_block')).then((value) {
                  print(value.body);
                  var data = jsonDecode(value.body);
                  print(data['message']);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
                });
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(translation(context).mine_block_error)));
              }




            })
          ],
        ),
      ),
    );
  }
  Widget Menu() {
    return Container(
      //4 boxes grid
        child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,

            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              //1st box


              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.replaceRemoveTo(
                        Flurorouter.adminoffersRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        color: goldcolor,
                        'assets/icons/menu-ofertas.svg',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        translation(context).manage_offers_text,
                        style: TextStyle(color: Colors.white,),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.replaceRemoveTo(
                        Flurorouter.withdrawsRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //icon for
                      Icon(Icons.access_alarm, color:goldcolor, size: 50,),
                      SizedBox(height: 20),
                      Text(
                        translation(context).withdrawal_request_text,

                        style: TextStyle(color: Colors.white,),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.replaceRemoveTo(
                       Flurorouter.usersRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        color: goldcolor,
                        'assets/icons/receipient.svg',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        translation(context).users_text,

                        style: TextStyle(color: Colors.white,),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              //casas de cambio
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.replaceRemoveTo(
                        Flurorouter.casasdecambioRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //icon Bank
                      Icon(Icons.account_balance, color:goldcolor, size: 50,),
                      SizedBox(height: 20),
                      Text(
                        translation(context).currency_exchange_text,
                        style: TextStyle(color: Colors.white,),
                          textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

            ]));
  }
}
