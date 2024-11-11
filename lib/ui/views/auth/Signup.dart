import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/models/http/auth_response.dart';


import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/local_storage.dart';
import '../../../services/navigation_service.dart';
import '../../../styles/custom_inputs.dart';
import '../../../theme.dart';
import '../../../shared/global_dialog.dart';


class SignupPage extends StatefulWidget {
  //parametros requeridos para la creacion de un usuario, type, required no es nada
  final String type;

  const SignupPage({Key? key, required this.type}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();


}

class _SignupPageState extends State<SignupPage> {
  String password = '';
  bool isLoading = false;

  String dropdownvalue = "";

  TextEditingController ctrlFirstName = TextEditingController();
  TextEditingController ctrlLastName = TextEditingController();
  TextEditingController ctrlDNI = TextEditingController();

  TextEditingController _ctrlPhone = TextEditingController();

  //INITIALIZE  _ctrlBirthday WITH TODAYS DATE
  TextEditingController _ctrlBirthday = TextEditingController(
      text: DateTime.now().toString().substring(0, 10));

  TextEditingController _ctrlEmail = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();
  TextEditingController ctrlConfirmPass = TextEditingController();
  DateTime selectedDate = DateTime.now();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownvalue = countries[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
              translation(context).create_account_as +' ' + (( widget.type == 'user') ? translation(context).user_text : translation(context)
              .seller_text),
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w100, fontSize: 18),),
    ),
    body: SingleChildScrollView(
    child: Container(
    color: backgroundcolor,
    padding: EdgeInsets.only(
    top: 20, bottom: 20, left: 20, right: 20),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[

    ( widget.type == 'user' )?Text(translation(context).by_creating_as_user, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100),):SizedBox(height: 0

    ),
    SizedBox(height: 10),
    accountForm(context),
    ]
    )
    ,
    )
    )
    );
  }


  _selectDate(BuildContext context) async {
    selectedDate = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            cardColor: Colors.black,
            primaryColor: goldcolor,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: goldcolor, // button text color
              ),
            ), colorScheme: ColorScheme.light(

              background: Colors.black,
              primary: goldcolor,
              // <-- SEE HERE
              onPrimary: Colors.black,
              // <-- SEE HERE
              onSurface: Colors.black,
              surface: Colors.black,

            ).copyWith(background: Colors.black),
          ),
          child: child!,
        );
      },
    ))!;
    setState(() {
      //set expire_date controller text to selectedDate formatted yyyy/mm/dd

      _ctrlBirthday.text = selectedDate.toString().substring(0, 10);
    });
    print(selectedDate);
  }

  //List<Map<String, String>> condo = [{'label': 'Condos', 'value': 'condo'}];
  List<String> countries = ["Republica Dominicana", "United States Of America"];
  final _formKey = GlobalKey<FormBuilderState>();

  void handleSubmit() async {
    //validate form email and check if email is valid
    if (_ctrlEmail.text.isEmpty || !_ctrlEmail.text.contains('@')) {
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
          SnackBar(
            content: Text(translation(context).email_required_must_valid,
                textAlign: TextAlign.center),
            backgroundColor: Colors.redAccent,
          )
      );
      return;
    }
    //validate form first name
    if (ctrlFirstName.text.isEmpty) {
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
          SnackBar(
            content: Text(
                translation(context).name_text + " " +
                    translation(context).is_required,
                textAlign: TextAlign.center),
            backgroundColor: Colors.redAccent,
          )
      );
      return;
    }
    //validate form last name
    if (ctrlLastName.text.isEmpty) {
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
          SnackBar(
            content: Text(
                translation(context).last_name + " " +
                    translation(context).is_required,
                textAlign: TextAlign.center),
            backgroundColor: Colors.redAccent,
          )
      );
      return;
    }

    //validate form dni
    if (ctrlDNI.text.isEmpty) {
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
          SnackBar(
            content: Text(
                translation(context).the_id_number + " " +
                    translation(context).is_required,
                textAlign: TextAlign.center),
            backgroundColor: Colors.redAccent,
          )
      );
      return;
    }
    //validate form phone
    if (_ctrlPhone.text.isEmpty) {
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
          SnackBar(
            content: Text(
                translation(context).phone + " " +
                    translation(context).is_required,
                textAlign: TextAlign.center),
            backgroundColor: Colors.redAccent,
          )
      );
      return;
    }
    //validate form country
    if (dropdownvalue.isEmpty) {
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
          SnackBar(
            content: Text(
                translation(context).country + " " +
                    translation(context).is_required+'El pais es requerido',
                textAlign: TextAlign.center),
            backgroundColor: Colors.redAccent,
          )
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    //validate form password
    if (ctrlPassword.text.isEmpty || ctrlPassword.text.length < 6) {
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
          SnackBar(
            content: Text(
                translation(context).password_required_must_6_characters,
                textAlign: TextAlign.center),
            backgroundColor: Colors.redAccent,
          )
      );
      return;
    }
    //validate form confirm password
    if (ctrlConfirmPass.text.isEmpty ||
        ctrlConfirmPass.text.length < 6 ||
        ctrlConfirmPass.text != ctrlPassword.text) {
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
          SnackBar(
            content: Text(
                translation(context).confirm_password_must_be_equal,
                textAlign: TextAlign.center),
            backgroundColor: Colors.redAccent,
          )
      );
      return;
    }

    try {
      //final user = await AuthService().register(values);
      //prepare nData to send to api

      //set globaldialog


      Map<String, String> nData = {
        "firstName": ctrlFirstName.text,
        "lastName": ctrlLastName.text,
        "dni": ctrlDNI.text,
        "phone": _ctrlPhone.text,
        "birthday": _ctrlBirthday.text,
        "country": dropdownvalue,
        "email": _ctrlEmail.text,
        "password": ctrlPassword.text,
        "password_confirmation": ctrlConfirmPass.text,
        "type": widget.type,
      };
      Provider.of<AuthProvider>(context, listen: false)
          .Register(nData);
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print(error);
    }
  }

  Widget accountForm(context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
                left: 0, right: 0, top: 10, bottom: 10),
            child: Column(
              children: [
                //outline input textfield for email
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: FormBuilderTextField(
                    style: TextStyle(color: Colors.white),
                    //<-- SEE HERE

                    cursorColor: goldcolor,
                    name: 'email',
                    controller: _ctrlEmail,
                    decoration: CustonImputs.accountInput(
                      label: 'Email',
                    ).copyWith(
                      suffixIcon: IconButton(
                        onPressed: () => _ctrlEmail.clear(),
                        icon: const Icon(Icons.close, color: goldcolor,),
                      ),
                      //set cursor color goldcolor
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                //outline input textfield for first name, golden border
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: FormBuilderTextField(
                    style: TextStyle(color: Colors.white),
                    //<-- SEE HERE

                    cursorColor: goldcolor,
                    name: 'first_name',
                    controller: ctrlFirstName,
                    decoration: CustonImputs.accountInput(
                      label: 'Primer nombre',
                    ).copyWith(

                      suffixIcon: IconButton(
                        onPressed: () => ctrlFirstName.clear(),
                        icon: const Icon(Icons.close, color: goldcolor,),
                      ),
                      //set cursor color goldcolor
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(2),
                    ]),
                    keyboardType: TextInputType.name,
                  ),
                ),
                //outline input textfield for last name, golden border
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: FormBuilderTextField(
                    style: TextStyle(color: Colors.white),
                    //<-- SEE HERE

                    cursorColor: goldcolor,
                    name: 'last_name',
                    controller: ctrlLastName,
                    decoration: CustonImputs.accountInput(
                      label: 'Apellido',
                    ).copyWith(

                      suffixIcon: IconButton(
                        onPressed: () => ctrlLastName.clear(),
                        icon: const Icon(Icons.close, color: goldcolor,),
                      ),
                      //set cursor color goldcolor
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(2),
                    ]),
                    keyboardType: TextInputType.name,
                  ),
                ),
                //outline input textfield for DNI, golden border
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: FormBuilderTextField(
                    style: TextStyle(color: Colors.white),
                    //<-- SEE HERE

                    cursorColor: goldcolor,
                    name: 'DNI',
                    controller: ctrlDNI,
                    decoration: CustonImputs.accountInput(
                      label: 'DNI',
                    ).copyWith(

                      suffixIcon: IconButton(
                        onPressed: () => ctrlDNI.clear(),
                        icon: const Icon(Icons.close, color: goldcolor,),
                      ),
                      //set cursor color goldcolor
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(2),
                    ]),
                    keyboardType: TextInputType.number,
                  ),
                ),
                //outline input textfield for phone, golden border
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: FormBuilderTextField(
                    style: TextStyle(color: Colors.white),
                    //<-- SEE HERE

                    cursorColor: goldcolor,
                    name: 'phone',
                    controller: _ctrlPhone,
                    decoration: CustonImputs.accountInput(
                      label: 'Telefono',
                    ).copyWith(

                      suffixIcon: IconButton(
                        onPressed: () => _ctrlPhone.clear(),
                        icon: const Icon(Icons.close, color: goldcolor,),
                      ),
                      //set cursor color goldcolor
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(2),
                    ]),
                    keyboardType: TextInputType.number,
                  ),
                ),

                //dropdown for country, backgroundcolor black, golden border , text  color white, and the list background color black
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                      ),
                    ),
                    dropdownColor: backgroundcolor,
                    style: TextStyle(color: Colors.white),
                    value: dropdownvalue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                    items: countries.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                //outline input form birthdate, golden border, datepicker box primary must be golden and the background color of the datepicker must be black
                //
                SizedBox(height: 20,),
                //label for birthdate
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 0),
                  child: Text(

                    translation(context).birthdate,
                    style: TextStyle(

                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () => _selectDate(context),
                  child:
                  Container(

                    child: TextField(
                      //forbid editing , but allow to click on suffix icon
                      enabled: false,
                      controller: _ctrlBirthday,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                      //white square border, with rounded corners, golden on focus
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: goldcolor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today, color: white),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                    ),
                  ),),
                SizedBox(height: 10,),
                //outline input textfield for password and confirm password, golden border
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: FormBuilderTextField(
                    obscureText: true,

                    style: TextStyle(color: Colors.white),
                    //<-- SEE HERE

                    cursorColor: goldcolor,
                    name: 'password',
                    controller: ctrlPassword,
                    decoration: CustonImputs.accountInput(
                      label: 'Contraseña',
                    ).copyWith(

                      suffixIcon: IconButton(
                        onPressed: () => ctrlPassword.clear(),
                        icon: const Icon(Icons.close, color: goldcolor,),
                      ),
                      //set cursor color goldcolor
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(2),
                    ]),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                //ctrlConfirmPass
                SizedBox(height: 10,),

                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: FormBuilderTextField(
                    //obscure text
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    //<-- SEE HERE
                    cursorColor: goldcolor,
                    name: 'confirmPassword',
                    controller: ctrlConfirmPass,
                    decoration: CustonImputs.accountInput(
                      label: 'Confirmar Contraseña',
                    ).copyWith(

                      suffixIcon: IconButton(
                        onPressed: () => ctrlConfirmPass.clear(),
                        icon: const Icon(Icons.close, color: goldcolor,),
                      ),
                      //set cursor color goldcolor
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(2),
                    ]),
                    //not visibl
                  ),
                ),

                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    //border gold
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: goldcolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),

                      onPressed: () {
                        handleSubmit();
                      }, child: Text(translation(context).create_account,
                    style: TextStyle(color: Colors.black),)

                  ),


                ),
                SizedBox(height: 20,),


              ],
            ),
          ),
        ],
      ),
    );
  }


}