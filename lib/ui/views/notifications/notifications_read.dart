import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../class/language_constants.dart';
import '../../../models/http/auth_response.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ui_provider.dart';
import '../../../theme.dart';


class NotificationReadView extends StatefulWidget {
  final int notifiPosition;
  const NotificationReadView({
    Key? key,
    required this.notifiPosition
  }) : super(key: key);

  @override
  State<NotificationReadView> createState() => _NotificationReadViewState();
}

class _NotificationReadViewState extends State<NotificationReadView> {

  NotificationsDatum? notifi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UiProvider>(context, listen: false).setAppBar(
        appBarTitle: translation(context).alerts_title,
        appBarBackBtn: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    if(authProv.myCondo != null) notifi = authProv.myCondo!.notifications.data[widget.notifiPosition];
    final DateFormat formatter = DateFormat('MMMM d y').add_jm();
    final String formatted = formatter.format(notifi!.date);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: Colors.grey.shade300,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notifi!.title, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: primaryColor)),
                    const SizedBox(height: 5),
                    Text(formatted, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: primaryColor))
                  ],
                ),
              ),
            )
          ],
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,//.horizontal
              child:  Text( notifi!.body,
                style:  TextStyle(
                  fontSize: 16.0, color: primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
