import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/http/auth_response.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ui_provider.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../shared/global_dialog.dart';
import '../../../styles/custom_inputs.dart';
import '../../../theme.dart';

class MyAccountView extends StatefulWidget {
  const MyAccountView({Key? key}) : super(key: key);

  @override
  State<MyAccountView> createState() => _MyAccountViewState();
}

class _MyAccountViewState extends State<MyAccountView> {
  AccountFormProvider? globalAccountFormProvider;

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            translation(context).edit_profile_text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
          ),
        ),
        bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
          if (idx == uiProvider.selectedMainMenu) return;
          uiProvider.selectedMainMenu = idx;
          uiProvider.appBarReset();
          NavigationService.navigateTo(
              uiProvider.pages[uiProvider.selectedMainMenu]);
        }),
        body: Container(
            height: double.infinity,
            color: backgroundcolor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(children: [
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(
                          vertical: 00, horizontal: 20),
                      child: Text(translation(context).my_account_subtitle,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w100) ),
                    ),
                    accountForm()
                  ]),

                ],
              ),
            )));
  }

  Widget accountForm() {
    final authProv = Provider.of<AuthProvider>(context);
    bool initial = false;
    User user = authProv.user!;

    return ChangeNotifierProvider(
        create: (_) => AccountFormProvider(),
        child: Builder(builder: (context) {
          final accountFormProvider = Provider.of<AccountFormProvider>(context);
          globalAccountFormProvider = accountFormProvider;
          TextEditingController ctrlName = TextEditingController(text:user.firstName.toString());
          TextEditingController _ctrlLastName = TextEditingController( text: user.lastname.toString());
          TextEditingController _ctrlPhone = TextEditingController( text: user.phone.toString());
          TextEditingController _ctrlBirthday = TextEditingController(  text: user.birthday.toString());
          TextEditingController _ctrlEmail = TextEditingController( text: user.email.toString());




          ctrlName.text = user.firstName ?? "";
          _ctrlLastName.text =user.lastname ?? "";
          _ctrlPhone.text = user.phone ?? "";
          _ctrlBirthday.text = user.birthday.toString() ?? "";
          _ctrlEmail.text = user.email ?? "";

          accountFormProvider.first_name = ctrlName.text;
          accountFormProvider.last_name = _ctrlLastName.text;
          accountFormProvider.phone = _ctrlPhone.text;
          accountFormProvider.birthday = _ctrlBirthday.text;

          return Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: accountFormProvider.formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        onFieldSubmitted: (_) =>
                            onFormSubmit(accountFormProvider),
                        controller: ctrlName,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return translation(context).my_account_add_name;
                          return null;
                        },
                        onChanged: (value) =>
                            accountFormProvider.first_name = value,
                        style: const TextStyle(color: Colors.white),
                        decoration: CustonImputs.accountInput(
                          label: translation(context).my_account_name,
                          hint: translation(context).my_account_name,
                        ).copyWith(
                          suffixIcon: IconButton(
                            onPressed: () => ctrlName.clear(),
                            icon: const Icon(Icons.close),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _ctrlLastName,
                        onFieldSubmitted: (_) =>
                            onFormSubmit(accountFormProvider),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return translation(context).my_account_add_lastname;
                          return null;
                        },
                        onChanged: (value) =>
                            accountFormProvider.last_name = value,
                        style: const TextStyle(color: white),
                        decoration: CustonImputs.accountInput(
                          label: translation(context).my_account_lastname,
                          hint: translation(context).my_account_lastname,
                        ).copyWith(
                          suffixIcon: IconButton(
                            onPressed: () => _ctrlLastName.clear(),
                            icon: Icon(Icons.close),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(

                        controller: _ctrlPhone,
                        onFieldSubmitted: (_) =>
                            onFormSubmit(accountFormProvider),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return translation(context).my_account_add_phone;
                          return null;
                        },
                        onChanged: (value) => accountFormProvider.phone = value,
                        style: const TextStyle(color: Colors.white),
                        decoration: CustonImputs.accountInput(
                          label: translation(context).my_account_phone,
                          hint: translation(context).my_account_phone,
                        ).copyWith(
                          suffixIcon: IconButton(
                            onPressed: () => _ctrlPhone.clear(),
                            icon: Icon(Icons.close),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      DateTimePicker(
                        locale: const Locale('es', 'ES'),
                        controller: _ctrlBirthday,
                        style: const TextStyle(color: Colors.white),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        decoration: CustonImputs.accountInput(
                          label: translation(context).my_account_birthday,
                          hint: translation(context).my_account_birthday,
                        ).copyWith(
                            // suffixIcon: IconButton(
                            //   onPressed: ()=> _ctrlBirthday.clear(),
                            //   icon: const Icon(Icons.close),
                            // ),
                            ),
                        dateLabelText: translation(context).my_account_birthday,
                        onChanged: (val) => accountFormProvider.birthday = val,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return translation(context).my_account_add_birthday;
                          return null;
                        },
                        onSaved: (val) => accountFormProvider.birthday = val!,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        readOnly: true,
                        controller: _ctrlEmail,
                        onFieldSubmitted: (_) =>
                            onFormSubmit(accountFormProvider),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return translation(context).add_email_text;
                          return null;
                        },
                        onChanged: (value) => accountFormProvider.phone = value,
                        style: const TextStyle(color: Colors.white),
                        decoration: CustonImputs.accountInput(
                          label: "Email",
                          hint: "Email",
                        ).copyWith(),
                      ),
                    ],
                  ),
                ),



                Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 0, bottom: 10),
                  child: Column(
                    children: [

                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      btnWidget(translation(context).my_account_update_profile,
                          goldcolor, 0, accountFormProvider),
                      const SizedBox(height: 10),
                      Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Text("Version 1.0.3",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: primaryColor)))
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }

  Widget btnWidget(String title, Color color, int type,
      AccountFormProvider accountFormProvider) {
    final authProv = Provider.of<AuthProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
                  onPressed: () => type == 1
                      ? GlobalTools()
                          .showConfirmation(
                              content:
                                  translation(context).my_account_logout_title)
                          .then((value) {
                          if (value as bool) authProv.logout();
                        })
                      : onFormSubmit(accountFormProvider),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundColor: color,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black),
                    ),
                  )))
        ],
      ),
    );
  }

  onFormSubmit(AccountFormProvider accountFormProvider) {
    final isValid = accountFormProvider.validateForm();
    if (isValid) {
      GlobalTools()
          .showConfirmation(
              content: translation(context).my_account_update_title)
          .then((value) {
        if (value as bool) updateProfile(accountFormProvider);
      });
    }
  }

  void updateProfile(AccountFormProvider accountFormProvider) {
    var nData = {
      'firstName': accountFormProvider.first_name,
      'lastName': accountFormProvider.last_name,
      'phone': accountFormProvider.phone,
      'birthday': accountFormProvider.birthday,
    };
  print(nData);


    HttpApi.putJson('/profile', nData).then((json) {
      print('profile updated');
      print(json);
      GlobalTools().showSnackBar(
          message: translation(context).my_account_update_success,
          color: Colors.green);
    }).catchError((e) {
      GlobalTools()
          .showSnackBar(message: translation(context).my_account_update_error);
      throw translation(context).my_account_update_error;
    });
  }
}

class AccountFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String first_name = '';
  String last_name = '';

  String phone = '';
  String birthday = '';
  String email = '';

  String password = '';
  String password_confirm = '';

  bool validateForm() {
    print("$password-|-$password_confirm");
    bool passwordValidate =
        ((password.length >= 8 && password.contains(password_confirm)) ||
            password.isEmpty);
    print("password $passwordValidate");

    if (formKey.currentState!.validate() && passwordValidate) {
      return true;
    } else {
      print('Form not valid');
      return false;
    }
  }
}
