import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../class/language_constants.dart';
import '../../../models/http/auth_response.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ui_provider.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {

  Notifications? notifi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UiProvider>(context, listen: false).setAppBar(
          appBarTitle: translation(context).alerts_title,
          appBarBackBtn: false,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    if(authProv.myCondo != null) notifi = authProv.myCondo!.notifications;

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF85aad5),
                    ),
                    onPressed: (){ print("You pressed Icon Elevated Button"); },
                    child:  Text(translation(context).alerts_mark_all_read, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white)),
                  )
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: notifi!.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return itemList(notifi!.data[index], index);
                }),
          ),
          //SizedBox(height:10),

        ],
      )
    );
  }


  Widget itemList(NotificationsDatum data, int index   ){

    final DateFormat formatter = DateFormat('MMMM d y').add_jm();
    final String formatted = formatter.format(data.date);

    return GestureDetector(
      onTap: ()=> NavigationService.navigateTo('/notification/$index'),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.title , style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)),
                      //Text("Novenber 17th 2022, 12:49:15 pm", style: Theme.of(context).textTheme.titleSmall),
                      Text(formatted , style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),


                ],
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }





}
