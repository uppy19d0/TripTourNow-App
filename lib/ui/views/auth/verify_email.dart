import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/http/error_http.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/global_dialog.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';

class MailVerificationPage extends StatefulWidget {
  const MailVerificationPage({Key? key}) : super(key: key);

  @override
  State<MailVerificationPage> createState() => _MailVerificationPageState();
}

class _MailVerificationPageState extends State<MailVerificationPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  //create bool variable isloading

  bool isLoading = false;
  //bool isdisabled
  bool isDisabled = true;
  //create 4 textformfields
  String _pin1 = '';
  String _pin2 = '';
  String _pin3 = '';
  String _pin4 = '';

  //override inistate

  @override
  void initState() {
    isLoading = true;
    print('initState');
    //call httpapi.get(/)
    //then set isLoading to false, catch error
    HttpApi.httpGet('/resend').then((value) {
      print(value);
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      print(error);
      setState(() {
        isLoading = false;
      });
    });

    isLoading = false;
  }

  //create function to validate the 4 textformfields
  void validatepins() {
    print('se validan los pin');
    if (_pin1.length == 1 &&
        _pin2.length == 1 &&
        _pin3.length == 1 &&
        _pin4.length == 1) {
      setState(() {
        isDisabled = false;
      });
    } else {
      setState(() {
        isDisabled = true;
      });
    }
  }
  //create function to send code , to be a callback for the button

  void sendCode() {
    //get the value of the 4 textformfields
    //call httpapi.get(/verify)
    //then set isLoading to false, catch error
    GlobalTools().showWaitDialog(waitText: translation(context).please_wait);
    print('se envia el codigo');
    setState(() {
      isLoading = true;
    });
    var code = _pin1 + _pin2 + _pin3 + _pin4;
    //send post request to verify code
    HttpApi.postJson('/store', {'code': code}).then((value) {
      print(value);

      print('redirecciona');
      NavigationService.replaceRemoveTo(Flurorouter.createAddressRoute);

      //removeuntil
    }).catchError((error) {
      //close dialog
      GlobalTools().closeDialog();
      //check if error is instance of ErrorHttp
      print('entre al error');
      //set snackbar red 'Codigo incorrecto'
      GlobalTools().showSnackBar(

          message: 'Codigo incorrecto',
          color: Colors.red);
      if (error is ErrorHttp) {
        print('entre al errorhttp');
        if (error.code == 401) {
          print('entre al errorhttp 401');
          //set snackbar red 'Codigo incorrecto'
          print(error.data);


        }
      }

      print(error);
    });
  }

  //create function to resend email
  void resendEmail() {
    GlobalTools().showWaitDialog(
        waitText: translation(context).please_wait);
    HttpApi.httpGet('/resend').then((value) {


      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
          SnackBar(
            content: Text(
                translation(context).codigo_sent_successful,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center),
            backgroundColor: goldcolor,
          )
      );
      //close dialog
      GlobalTools().closeDialog();
    }).catchError((error) {
      GlobalTools().closeDialog();
      print(error.data);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(translation(context).confirm_code),
          //icon back redicrect to homeRoute
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              NavigationService.replaceRemoveTo(Flurorouter.homeRoute);
            },
          ),
        ),
        body: Container(
            height: double.infinity,
            color: backgroundcolor,
            child: SingleChildScrollView(
              child: Container(
                color: backgroundcolor,
                padding:
                    EdgeInsets.only(top: 10, bottom: 20, left: 40, right: 40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 70),
                      Text(
                        translation(context).we_sent_a_code,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        translation(context).check_your_spam,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        translation(context).code_verification,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                height: 68,
                                width: 64,
                                child: TextFormField(
                                  cursorColor: goldcolor, //<-- SEE HERE


                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                      _pin1 = value;
                                    }
                                    if (value.length == 0) {
                                      FocusScope.of(context).previousFocus();

                                      _pin1 = value;
                                    }
                                    validatepins();
                                  },
                                  onSaved: (pin1) {
                                    _pin1 = pin1!;
                                  },
                                  decoration: InputDecoration(

                                    filled: true,
                                    fillColor: Colors.black,
                                    hintText: 'E-mail',
                                    //cursor golden
                                    contentPadding: EdgeInsets.all(12),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: goldcolor),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                )),
                            SizedBox(
                                height: 68,
                                width: 64,
                                child: TextFormField(
                                  cursorColor: goldcolor, //<

                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();

                                      _pin2 = value;
                                    }
                                    if (value.length == 0) {
                                      FocusScope.of(context).previousFocus();

                                      _pin2 = value;
                                    }
                                    validatepins();
                                  },
                                  onSaved: (pin2) {
                                    _pin2 = pin2!;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.black,
                                    contentPadding: EdgeInsets.all(12),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: goldcolor),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                )),
                            SizedBox(
                                height: 68,
                                width: 64,
                                child: TextFormField(
                                  cursorColor: goldcolor,

                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                      _pin3 = value;
                                    }
                                    //if the value is empty, focus on previous textformfield
                                    if (value.length == 0) {
                                      FocusScope.of(context).previousFocus();

                                      _pin3 = value;
                                    }
                                    validatepins();
                                  },
                                  onSaved: (pin3) {
                                    _pin3 = pin3!;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.black,
                                    contentPadding: EdgeInsets.all(12),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: goldcolor),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                )),
                            SizedBox(
                                height: 68,
                                width: 64,
                                child: TextFormField(
                                  cursorColor: goldcolor, //<


                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                      _pin4 = value;
                                    }
                                    if (value.length == 0) {
                                      FocusScope.of(context).previousFocus();

                                      _pin4 = value;
                                    }
                                    validatepins();
                                  },
                                  onSaved: (pin4) {
                                    _pin4 = pin4!;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.black,
                                    contentPadding: EdgeInsets.all(12),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: goldcolor),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                )),
                          ]),
                      SizedBox(height: 150),
                      ElevatedButton(
                        onPressed: isDisabled ? null : () => sendCode(),
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              translation(context).confirm,
                              style: TextStyle(
                                  color: (isDisabled)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w600),
                            )),
                        style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: greycolor,
                            backgroundColor: primaryColor),
                      ),
                      SizedBox(height: 50),
                      Text(
                        translation(context).didnt_receive_code,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => resendEmail(),
                        child: Text(
                          translation(context).resend_code,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: goldcolor),
                          textAlign: TextAlign.center,
                        ),),
                      //text and link to resend code

                    ]),
              ),
            )));
  }
}
