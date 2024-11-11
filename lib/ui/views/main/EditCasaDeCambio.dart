import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/models/CasaDeCambio.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditCasaDeCambio extends StatefulWidget {
  final int id;
  const EditCasaDeCambio({Key? key, required this.id}) : super(key: key);
  @override
  State<EditCasaDeCambio> createState() => _EditCasaDeCambioState();
}

class _EditCasaDeCambioState extends State<EditCasaDeCambio> {
  String imagepath = '';
  String url = '';
  late File imageFile;
  //booleans for checkboxes
  bool usd = false;
  bool eur = false;
  bool dop = false;
  bool gbp = false;
  bool chf = false;
  bool cad = false;
  //text controllers for name, address, phone
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  //google map link controller
  TextEditingController googlemaplinkController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState


    HttpApi.httpGet('/casa_de_cambio/'+widget.id.toString()).then((value) {

      //convert value to json
      var data=   value['data'];

        CasaDeCambio casa = CasaDeCambio.fromJson(data);
        print(data);

      setState(() {
    //update all the fields with the data from the api
        nameController.text = casa.name;
        addressController.text = casa.address;
        phoneController.text = casa.phone;
        googlemaplinkController.text = casa.googlemaplink;
        url = 'http://3.16.217.214/'+casa.image;
     
        usd = casa.usd;
        eur = casa.eur;
        dop = casa.dop;
        gbp = casa.gbp;
        chf = casa.chf;
        cad = casa.cad;

      });
    }).catchError((error) {
      print(error);
      print(error.data);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(translation(context).create_currency_exchange),
          //icon to go back
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => {
                NavigationService.replaceRemoveTo(
                    Flurorouter.casasdecambioRoute)
              }),
        ),
        bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
          if (idx == uiProvider.selectedMainMenu) return;
          uiProvider.selectedMainMenu = idx;
          uiProvider.appBarReset();
          NavigationService.navigateTo(
              uiProvider.pages[uiProvider.selectedMainMenu]);
        }),
        //add floating action button

        body: Container(
          color: backgroundcolor,
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                //form with the following fields image_picker for image, name, address, phone, chechboxes for the following currencies (usd,eur,dop,gbp,chf, cad)
                //image_picker
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  child: Text(
                    translation(context).cover_of_the_currency_exchange,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: GestureDetector(
                    onTap: () async {
                      uploadImage();
                    },
                    child: (imagepath == '') ? goldenBox() : imageBox(),
                  ),
                ),
                SizedBox(height: 20),
                //name
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  child: Text(
                    translation(context).name_of_the_currency_exchange,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //texfield for name , golden border, golden text, wihout dotterborder, cursor color gold
                Container(
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(
                      color: goldcolor,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //address
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  child: Text(
                    translation(context).address_of_the_currency_exchange,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //texfield for address , golden border, golden text, wihout dotterborder, cursor color gold
                Container(
                  child: TextField(
                    controller: addressController,
                    style: TextStyle(
                      color: goldcolor,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //phone
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  child: Text(
                    translation(context).phone_of_the_currency_exchange,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //texfield for phone , golden border, golden text, wihout dotterborder, cursor color gold
                Container(
                  child: TextField(
                    controller: phoneController,
                    style: TextStyle(
                      color: goldcolor,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                //textarea for the google maps link
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  child: Text(
                    translation(context).google_maps_link,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //texfield for link , golden border, golden text, wihout dotterborder, cursor color gold , multiline
                Container(
                  child: TextField(
                    controller: googlemaplinkController,
                    style: TextStyle(
                      color: goldcolor,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20,
                          vertical: 20  ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: goldcolor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLines: 5,
                  ),
                ),
                //checkboxListTile for the currencies
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  child: Text(
                    translation(context).coins_that_handle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CheckboxListTile(
                  selectedTileColor: Colors.black,
                  checkColor: Colors.black,
                  activeColor: goldcolor,
                  tileColor: Colors.black,
                  title: Text(
                    translation(context).coin_type_dollar,
                    style: TextStyle(
                      color: goldcolor,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  value: usd,
                  onChanged: (value) {
                    setState(() {
                      usd = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  selectedTileColor: Colors.black,
                  checkColor: Colors.black,
                  activeColor: goldcolor,
                  tileColor: Colors.black,
                  title: Text(
                    'Euro',
                    style: TextStyle(
                      color: goldcolor,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  value: eur,
                  onChanged: (value) {
                    setState(() {
                      eur = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  selectedTileColor: Colors.black,
                  checkColor: Colors.black,
                  activeColor: goldcolor,
                  tileColor: Colors.black,
                  title: Text(
                    translation(context).coin_type_pound,
                    style: TextStyle(
                      color: goldcolor,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  value: gbp,
                  onChanged: (value) {
                    setState(() {
                      gbp = value!;
                    });
                  },
                ),
                //dop
                CheckboxListTile(
                  selectedTileColor: Colors.black,
                  checkColor: Colors.black,
                  activeColor: goldcolor,
                  tileColor: Colors.black,
                  title: Text(
                    translation(context).coin_type_dominican_peso,
                    style: TextStyle(
                      color: goldcolor,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  value: dop,
                  onChanged: (value) {
                    setState(() {
                      dop = value!;
                    });
                  },
                ),
                //cad
                CheckboxListTile(
                  selectedTileColor: Colors.black,
                  checkColor: Colors.black,
                  activeColor: goldcolor,
                  tileColor: Colors.black,
                  title: Text(
                    translation(context).coin_type_canadian_dollar,
                    style: TextStyle(
                      color: goldcolor,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  value: cad,
                  onChanged: (value) {
                    setState(() {
                      cad = value!;
                    });
                  },
                ),
                //   chf
                CheckboxListTile(
                  selectedTileColor: Colors.black,
                  checkColor: Colors.black,
                  activeColor: goldcolor,
                  tileColor: Colors.black,
                  title: Text(
                    translation(context).coin_type_swiss_franc,
                    style: TextStyle(
                      color: goldcolor,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  value: chf,
                  onChanged: (value) {
                    setState(() {
                      chf = value!;
                    });
                  },
                ),
                //golden button Registrar
                SizedBox(height: 20),
                //elevated button
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldcolor,
                      padding:
                      EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    onPressed: () {
                      //validate that image is selected
                      handleSubmit();
                    },
                    child: Text(translation(context).submit_option,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        )),
                  ),
                ),
              ]),
        ));
  }

  Widget goldenBox() {
    return Container(
      //box is a quare, with dashed golden border
      child: DottedBorder(
        color: goldcolor,
        strokeWidth: 1,
        dashPattern: [5, 5],
        child: Container(
            height: 200,
            width: double.infinity,
            child: Center(

              child: (url=='')? Container(
                //golden circular progress indicator
                child: CircularProgressIndicator(
                  color: goldcolor,
                ),
              ): Image.network(url)
              ),
            )),

    );
  }

  void uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagepath = pickedFile.path;
        //create fileFile(_imageFileList![index].path),
        imageFile = File(pickedFile.path);
        //send the image to the server
      });
    } else {
      print('No image selected.');
    }
  }

  Widget imageBox() {
    //return a container with the image just selected with image_picker
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      child: DottedBorder(
        color: goldcolor,
        strokeWidth: 1,
        dashPattern: [5, 5],
        child: Container(
            height: 200,
            width: double.infinity,
            child: Center(
              child: (imagepath == '')
                ? Image.file(
              imageFile!,
              fit: BoxFit.cover,
            )
                : Image.network(url),
            )),
      ),
    );
  }

  //handle the submit button
  void handleSubmit() {
    int error = 0;

    if (imagepath == null || imagepath == '') {
      //show a snackbar
      final snackBar = SnackBar(
        content: Text(translation(context).select_image_error),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      error = error + 1;
    }
    if (usd == false && eur == false && gbp == false && dop == false && cad == false && chf == false) {
      //show a snackbar
      final snackBar = SnackBar(
        content: Text(translation(context).select_coin_error),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      error = error + 1;
    }
    //validar nombre
    if (nameController.text == '') {
      //show a snackbar
      final snackBar = SnackBar(
        content: Text(translation(context).name_input_error),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      error = error + 1;
    }
    //validar telefono
    if (phoneController.text == '') {
      //show a snackbar
      final snackBar = SnackBar(
        content: Text(translation(context).phone_input_error),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      error = error + 1;
    }
    //direccion
    if (addressController.text == '') {
      //show a snackbar
      final snackBar = SnackBar(
        content: Text(translation(context).address_input_error),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      error = error + 1;
    }
    if (error == 0) {
      //show loading dialog
      GlobalTools().showWaitDialog(
          waitText: translation(context).creating_currency_exchange);
      //send the image to the server
      var ndata = {
        'name': nameController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        //googlemaplink
        'googlemaplink': googlemaplinkController.text,
        'usd': usd,
        'eur': eur,
        'gbp': gbp,
        'dop': dop,
        'cad': cad,
        'chf': chf,
      };
      print('se manda');
      if (imageFile != null) {
        ndata['imageUrl'] = imageFile;
        HttpApi.postWithImage(
            '/casa_de_cambio/update/'+ widget.id.toString(), ndata, imageFile)
            .then((value) {
          if (value['status'] == 'success') {
            GlobalTools().closeDialog();
            //Navigator.pushNamed(context, '/success');
            NavigationService.replaceRemoveTo(
                Flurorouter.casasdecambioRoute);
          }
        }).catchError((error) {
          print(error);
          print(error.data);
        });
      } else {
        HttpApi.postJson('/casa_de_cambio/update/'+ widget.id.toString(), ndata)
            .then((value) {
          if (value['status'] == 'success') {
            GlobalTools().closeDialog();
            //Navigator.pushNamed(context, '/success');
            NavigationService.replaceRemoveTo(
                Flurorouter.casasdecambioRoute);
          }
        }).catchError((error) {
          print(error);
          print(error.data);
        });
      }
    }

  }
}
