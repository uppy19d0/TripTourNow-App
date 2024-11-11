import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';

class PassResetView extends StatefulWidget {
  const PassResetView({super.key});

  @override
  State<PassResetView> createState() => _PassResetViewState();
}

class _PassResetViewState extends State<PassResetView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(translation(context).my_account_change_password, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100),),
      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo(
            uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      body: Container(
        color: backgroundcolor,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 16),
              Container(
                width: double.infinity,

                child: Text(translation(context).input_new_pasword_text, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w100),),
              ),
              SizedBox(height: 16),
              //password textformfield, border gold, text white and gold validate
              TextFormField(
                cursorColor: goldcolor,
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  //user ttc icon and TTC texts as suffix,
                  //suffixicon, iconbutton
                  //suffixicon paste button

                  hintText: translation(context).my_account_change_password,
                  hintStyle: TextStyle(color: Colors.white),

                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return translation(context).please_put_password_text;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                style: TextStyle(color: Colors.white),

                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  hintText: translation(context).confirm_password_text,
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return translation(context).please_confirm_password_text;
                  }
                  if (value != _passwordController.text) {
                    return translation(context).password_no_match_text;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child:

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40), backgroundColor: goldcolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform password reset logic here
                    GlobalTools().showWaitDialog(
                    waitText: translation(context).please_wait);

                    var data= {
                      'password':_passwordController.text,
                      'password_confirmation':_confirmPasswordController.text,
                    };

                    HttpApi.postJson('/password/change', data).then((value) {
                      print(value);
                      GlobalTools().closeDialog();
                      if (value['status'] == 'success') {
                        print('success');
                        ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                            .showSnackBar(
                            SnackBar(
                              content: Text(
                                  translation(context).password_changed_text,style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center),
                              backgroundColor: Colors.green,
                            )
                        );


                      } else {
                        ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                            .showSnackBar(
                            SnackBar(
                              content: Text(
                                  translation(context).something_wrong_error,style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.center),
                              backgroundColor: Colors.redAccent,
                            )
                        );
                      }
                    });
                  }
                },
                child: Text(translation(context).my_account_change_password, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
