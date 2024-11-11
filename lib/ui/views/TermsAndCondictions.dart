import 'package:flutter/material.dart';

import '../../class/language_constants.dart';
import '../../services/generals.service.dart';
import '../../theme.dart';
import 'package:webview_flutter/webview_flutter.dart';


// ignore: import_of_legacy_library_into_null_safe


class TermsAndCondictionsPage extends StatefulWidget {
  @override
  _TermsAndCondictionsPageState createState() => _TermsAndCondictionsPageState();
}

class _TermsAndCondictionsPageState extends State<TermsAndCondictionsPage> {
  bool _isLoading = true;
  String text = '';
  String error = '';


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).login_terms_service, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w100)),
        backgroundColor: Colors.black,

      ),
      body:Container(
        //webview to https://triptourcoin.com/condiciones-de-uso-tiptourcoin/
        child:WebView(
          initialUrl: 'https://triptourcoin.com/condiciones-de-uso-tiptourcoin/',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      )
    );
  }
}