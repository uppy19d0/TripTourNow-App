import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../router/router.dart';
import '../../services/navigation_service.dart';
import '../../providers/auth_provider.dart';
import '../../providers/ui_provider.dart';
import '../../shared/global_dialog.dart';
import '../../theme.dart';
import './auth/Signup.dart';
import '../../class/language_constants.dart';
import '../../utils/Animations.dart';
import './auth/ForgotPassword.dart';
import 'PrivacyPolicity.dart';
import 'TermsAndCondictions.dart';
//font awesome icons
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool rememberMe = false;
  bool isLoading = false;
  String email = "";
  String password = "";
  bool _obscureText = true;



  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formkey = new GlobalKey<FormBuilderState>();

  void handleLogin(context, values) async {
    setState(() {
      isLoading = true;
    });

    try {} catch (error) {
      setState(() {
        isLoading = false;
      });

      // if(globalKey.currentContext != null){
      //   showError(error.toString());
      // }
    }
  }

  void showError(message) {
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(SnackBar(
      content: Text(message, textAlign: TextAlign.center),
      backgroundColor: Colors.redAccent,
    ));
  }

  void redirectUser(user) {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void initState() {
    super.initState();
    checkiflogged();
  }

  Future<void> checkiflogged() async {
    final local = await SharedPreferences.getInstance();
    final user = local.getString('user');
    if (user != null) {
      redirectUser(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        //icon flag to go back
        leading: IconButton(
            //FONTAWESOMEICON TO GO BACK
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
            ),
            onPressed: () => {
              //return to splash
              //route rootRoute
              Navigator.popAndPushNamed(context, Flurorouter.rootRoute)

            }
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(translation(context).login_title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100
        ),),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          SizedBox(height: 25),
          Image(
            image: AssetImage('assets/logo-ttc.png'),
            height: 100,
          ),
          SizedBox(height: 20),
          Text(translation(context).login_sub_title,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 15),
          FormBuilder(
            key: _formkey,
            child: Column(children: <Widget>[
              FormBuilderTextField(
                cursorColor: goldcolor,
                style: TextStyle(fontSize: 14.0, color: white),
                name: 'email',
                initialValue: "",
                onChanged: (value) => email = value!,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'E-mail',
                  contentPadding: EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: goldcolor),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: translation(context).email_is_required),
                  FormBuilderValidators.email(
                      errorText: translation(context).email_is_invalid),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                //icon to show password

                cursorColor: goldcolor,
                style: TextStyle(fontSize: 14.0, color: white),
                name: 'password',
                initialValue: "",
                onChanged: (value) => password = value!,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      _toggle();
                    },
                  ),

                  //icon to show password

                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'E-mail',
                  contentPadding: EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: goldcolor),
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: translation(context).password_is_required),
                  FormBuilderValidators.minLength(8,
                      errorText: translation(context).password_lenght_error)
                ]),
              ),
            ]),
          ),
          SizedBox(height: 15),
          ElevatedButton(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    translation(context).login_login_in_btn,
                    style: TextStyle(
                        color: Color(0xFF191E24), fontWeight: FontWeight.w600),
                  )),
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: isLoading
                  ? null
                  : () {
                      if (!_formkey.currentState!.saveAndValidate()) {
                        return;
                      }

                      Provider.of<UiProvider>(context, listen: false)
                          .selectedMainMenu = 0; // Reinicia el menu
                      try {
                        Provider.of<AuthProvider>(context, listen: false)
                            .login(email, password);
                      } catch (e) {
                        print(e);
                        //show red snackbar

                      }

                      //Navigator.pushReplacementNamed(context, '/Home');
                    }),
          SizedBox(height: 10),
          Wrap(alignment: WrapAlignment.center, children: <Widget>[
            Text(translation(context).login_forgot_pass_title,
                style: TextStyle(color: Colors.white)),
            GestureDetector(
              child: Text(translation(context).login_forgot_pass_btn,
                  style: TextStyle(
                      color: goldcolor, decoration: TextDecoration.underline)),
              onTap: () {
                Navigator.of(context)
                    .push(bottomAnimation(const ForgotPasswordPage()));
              },
            )
          ]),
          SizedBox(height: 30),

          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
              child: Container(
                  child: Text(
                    translation(context).login_register,
                    style: TextStyle(color: Color(grayText)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12)),
              //onPressed: (){},
              onPressed: () {
                Navigator.of(context).push(bottomAnimation(SignupPage( type: 'user',)));
              }),
          SizedBox(height: 25),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
              child: Container(
                  child: Text(
                    translation(context).register_as_text + " " + translation(context).seller_text,
                    style: TextStyle(color: Color(grayText)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12)),
              //onPressed: (){},
              onPressed: () {
                Navigator.of(context).push(bottomAnimation(SignupPage(
                  type: 'seller',
                )));
              }),
          SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                translation(context).login_footer_title,
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                  child: Text(
                    " " + translation(context).login_terms_service + ' ',),

                  onTap: () {
                    Navigator.of(context)
                        .push(bottomAnimation(TermsAndCondictionsPage()));
                  }),
              Text(
                translation(context).login_and_the,
                style: TextStyle(color: Colors.white),
              ),
              GestureDetector(
                  child: Text(" " + translation(context).login_privacy_policy,
                      style:
                          TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white)),
                  onTap: () {
                    Navigator.of(context)
                        .push(bottomAnimation(PrivacyPolicityPage()));
                  })
            ],
          ),
          SizedBox(height: 2),
          SizedBox(height: 20)
        ]),
      )),
    );
  }
}
