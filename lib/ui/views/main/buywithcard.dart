import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//required imports for webview
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

import '../../../class/language_constants.dart';
import '../../../models/http/auth_response.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';
//flurorouter
import '../../../router/router.dart';



class BuyWithCard extends StatefulWidget {
  final double amount;
  const BuyWithCard({super.key, required  this.amount});

  @override
  State<BuyWithCard> createState() => _BuyWithCardState();
}

class _BuyWithCardState extends State<BuyWithCard> {
  String userid = '0';


  @override
  Widget build(BuildContext context) {

    final authProv = Provider.of<AuthProvider>(context);

    User current = authProv.user!;
    userid = current.id.toString();
    @override
    void initState() {
      super.initState();
      // Enable hybrid composition.
      if (defaultTargetPlatform == TargetPlatform.android) {
        WebView.platform = SurfaceAndroidWebView();
      }
      setState(() {
        userid = current.id.toString();
      });
    }
    //webview
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).buy_with_card_text),
        backgroundColor: Colors.black,
        //icon back
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //flurorouter.mywallet
            NavigationService.replaceRemoveTo(
                Flurorouter.myWalletRoute);


          },
        ),
      ),
      //icon back

      body: CustomWebview(),

    );
  }

  //custom webview
  Widget CustomWebview() {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      return Container(
        color: backgroundcolor,
          child: Center(
        child: Text(
          translation(context).page_not_supported_windows,
          style: TextStyle(color: goldcolor),
        ),)
      );
    } else {
      return WebView(
        initialUrl: 'https://triptournow.com/paypal/open?amount=${widget
            .amount}&userid=${userid}',
        javascriptMode: JavascriptMode.unrestricted,
      );
    }
  }
}