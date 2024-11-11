import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../api/HttpApi.dart';
import '../../../theme.dart';

import '../../../class/language_constants.dart';
//webview
import 'package:webview_flutter/webview_flutter.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    Key? key
  }) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  String errorText = '';



  @override
  Widget build(BuildContext context) {

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(translation(context).forgot_pass_title, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w100)),
      ),
      body:
      Container(
        height: double.infinity,
        color: backgroundcolor,
        //webview to https://triptournow.com/password/reset
        child: WebView(
          initialUrl: 'https://triptournow.com/password/reset',
          javascriptMode: JavascriptMode.unrestricted,
        ),

        //

    ),
    );
  }


  void submitEmail(context, String email) async {
    setState(() {
      _isLoading = true;
      errorText = '';
    });


    HttpApi.postJson('/password/recovery', {'email': email}).then((json) {
      print(json);
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context)
          .showSnackBar(
          SnackBar(
            content: Text(translation(context).email_is_sent, textAlign: TextAlign.center),
            backgroundColor: Colors.green,
          )
      );
    }).catchError((e) {
      print(e);
      setState(() {
        _isLoading = false;
        errorText = e.toString();
      });
      throw 'Error';
    });
      //await AuthService().forgotPassword(email);


  }





}

