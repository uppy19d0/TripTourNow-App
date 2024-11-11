import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/theme.dart';
import '../../../api/HttpApi.dart';
import 'package:flutter/services.dart';
import '../../../class/language_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';

class CreateAddressPage extends StatefulWidget {
  const CreateAddressPage({super.key});

  @override
  State<CreateAddressPage> createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage> {
  List<dynamic> words = [];
  String outputwords = "";
  bool checkstatus = false;

  @override
  void initState() {
    //call authprovider currentuser




    //call route
    // call get route to create/words using httpApi catch errors
    // if error show error message
    // if success show words
    HttpApi.httpGet('/create/words').then((value) {
      setState(() {
        words = value['mnemonic'];
        //save words to string, but remove []
        outputwords = words.toString();
        outputwords = outputwords.replaceAll('[', '');
        outputwords = outputwords.replaceAll(']', '');
        print(outputwords);
      });
    }).catchError((error) {
      print(error);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translation(context).wallet_creation_text),
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              color: backgroundcolor,
              child: ListView(
                children: [
                  SizedBox(
                    height: 40,
                  ),

                  Text(
                    translation(context).save_keywords_safe_text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Container(child:
                  Text(
                    translation(context).words_private_key_save_it_text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),),
             

                  SizedBox(
                    height: 20,
                  ),
                  //create paragraph with copy icon
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: greycolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          outputwords,
                          style: TextStyle(
                            color: goldcolor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //boton copiar al portapapeles

                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        //copy words to clipboard

                        Clipboard.setData(ClipboardData(text: outputwords));
                        //show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(translation(context).copied_clipboard_text)));
                      },
                      child: Text(translation(context).copy_to_clipboard_text,
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: goldcolor,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: 20),

                  Row(
                    children: <Widget>[
                      Checkbox(
                        //make it gold when checked, and white background
                        activeColor: goldcolor,
                        checkColor: Colors.black,

                        value: checkstatus,
                        onChanged: (bool? value) {
                          setState(() {
                            checkstatus = value!;
                          });
                        },
                      ),
                      Expanded(child:
                      Text(
                        translation(context).copied_private_key_to_safeplace_text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )),
            Container(
              //transparent backgroundcolor
              color: Colors.black,
              padding:
                  EdgeInsets.only(top: 15, right: 40, left: 40, bottom: 15),
              child: Column(
                children: <Widget>[
                  //checkbox para garantizar que copiaron la llave privada
                  //elevated button para continuar, disabled si no se ha copiado la llave privada
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      //make height bigger
                      onPressed: (!checkstatus)
                          ? null
                          : () {
                              final authProvider = Provider.of<AuthProvider>(context!,listen: false);

                        //if user.entropy_created == false
                        //return EntropyPage();
                              authProvider.user?.entropy_created =true;
                              print(authProvider.user?.entropy_created);
                              print("se cambia");

                              //redirect to homeroute using router
                              print('redirecting to home route');
                              NavigationService.replaceRemoveTo(
                                  Flurorouter.homeRoute);
                            },
                      child: Text(translation(context).continue_text,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: goldcolor,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        disabledBackgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
