import 'package:flutter/material.dart';

import '../../services/generals.service.dart';
//webview
import 'package:webview_flutter/webview_flutter.dart';

// ignore: import_of_legacy_library_into_null_safe
import '../../class/language_constants.dart';
import '../../theme.dart';
class PrivacyPolicityPage extends StatefulWidget {
  @override
  _PrivacyPolicityPageState createState() => _PrivacyPolicityPageState();
}

class _PrivacyPolicityPageState extends State<PrivacyPolicityPage> {
  bool _isLoading = true;
  String text = '';
  String error = '';

  void getTermsAndConditions() async{
    try {
      final terms = await GeneralService().getPrivacyPolicy();
      setState(() {
        text = terms;
        _isLoading = false;
      });
    }catch(err){
      setState(() {
        error = err.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.getTermsAndConditions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).login_privacy_policy, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w100)),
        backgroundColor: Colors.black,

      ),
      body:Container(
        //webview to https://triptourcoin.com/condiciones-de-uso-tiptourcoin/
        child:WebView(
          initialUrl: 'https://triptourcoin.com/politica-de-la-privacidad',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      )
    );
  }
}