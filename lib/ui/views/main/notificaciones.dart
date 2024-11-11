import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:trip_tour_coin/theme.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../layouts/core_layaout.dart';
import 'package:intl/intl.dart';

class NotificacionesPage extends StatefulWidget {
  const NotificacionesPage({Key? key}) : super(key: key);

  @override
  State<NotificacionesPage> createState() => _NotificacionesPageState();
}

class _NotificacionesPageState extends State<NotificacionesPage> {
  bool isloading = true;
  //list for notifications
  List notifications = [];


  @override
  void initState() {
    HttpApi.httpGet('/notifications').then((value) {

      //convert value to json
      var data=   value;
print(data);
    print(value['notifications']);
    //store the notifications in the list coming from the api
      var notif = value['notifications'];
      setState(() {
        notifications = notif;
      });
      //foreach notification, print it
      print('se imprime');
      for(var notif in notifications){
        print(notif['data']);
      }



      setState(() {
        isloading = false;
      });
    }).catchError((error) {
      print(error);
      print(error.data);
    });
  }
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(translation(context).notifications_text, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: () {
            //flurorouter.redirect ;
            NavigationService.replaceRemoveTo(
                Flurorouter.homeRoute);
          },
        ),
        //icon to go back

      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo( uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      body:Container(
        color : backgroundcolor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: (isloading)?Container(child :Center(
          child: CircularProgressIndicator(
            color: goldcolor,
          ),
        )):
        ListView(
          children: [

            SizedBox(height: 20,),

            Divider(
              color: Colors.white,
            ),
            (notifications.length == 0)?
            Text(translation(context).no_notifications_text, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),):
            Container(child:
           //user listbiew bulder to show the notifications
            ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.white,
              ),
              shrinkWrap: true,
              //divider between the notifications
              physics: NeverScrollableScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (BuildContext context, int index) {

          return ListTile(
            title: Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(notifications[index]['created_at'])), style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w100),),
            subtitle: Text((notifications[index]['data']['data']!), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white,),
          );
              },
              ),
            )
          ,
          Divider(
            color: Colors.white,
          )],
        )
      ),

    );
  }
}

