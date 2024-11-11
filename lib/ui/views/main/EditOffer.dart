import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/models/Offer.dart';
import 'dart:io';
import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';

class EditOffer extends StatefulWidget {
  final Offer offer;
  const EditOffer({
    Key? key,
    required this.offer,
  }) : super(key: key);

  @override
  State<EditOffer> createState() => _EditOfferState();
}

class _EditOfferState extends State<EditOffer> {
  String imagepath = '';
  late File imageFile;
  //datetime selected set 2 weeks from now
  DateTime selectedDate = DateTime.now().add(Duration(days: 14));
  bool isdisabled = false;
  late Offer oferta;
  double total = 0.0;
  String url='';
  bool haschanged=false;

  //form editing controllers for text fields title, subtitle, description, expire_date, price
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //initialize expire_date controller with selectedDate formatted yyyy/mm/dd
  TextEditingController expire_dateController = TextEditingController(
      text: DateTime.now().add(Duration(days: 14)).toString().substring(0, 10));
  // initialize price controller with 0.0
  TextEditingController priceController = TextEditingController(text: '0.0');

  _selectDate(BuildContext context) async {
    selectedDate = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
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
              primary: goldcolor, // <-- SEE HERE
              onPrimary: Colors.black, // <-- SEE HERE
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

      expire_dateController.text = selectedDate.toString().substring(0, 10);
    });
    print(selectedDate);
  }

  @override
  void initState() {
    setState(() {
      oferta = widget.offer;
      total = oferta.price;
      imagepath = oferta.urlPost;

      //set title controller text to offer title
      titleController.text = oferta.title;

      //set subtitle controller text to offer subtitle
      subtitleController.text = oferta.subTitle;

      //set description controller text to offer description
      descriptionController.text = oferta.description;
      priceController.text = oferta.price.toString();
      url = oferta.urlPost;
      //set expire_date controller text to offer expire_date
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).offer_edit_text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: goldcolor,
          ),
          onPressed: () {
            NavigationService.replaceRemoveTo(
                Flurorouter.homeRoute);
          },
        ),
      ),
      body: Container(
          height: double.infinity,
          color: backgroundcolor,
          width: double.infinity,
          child: ListView(children: [
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Text(
                translation(context).offer_image_text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Text(
                translation(context).offer_title_text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: TextField(
                controller: titleController,
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
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Text(
                translation(context).offer_subtitle_text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: TextField(
                controller: subtitleController,
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
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Text(
                translation(context).offer_description_text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 10),
            //textarea for description
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 2, //Normal textInputField will be displayed
                maxLines: 5, // when user presses enter it will adapt to it
                controller: descriptionController,
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
                ),
              ),
            ),
            SizedBox(height: 20),
            //Precio de la oferta
            Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translation(context).offer_price_text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Text(
                      '1 TTC = 1.00 USD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 10),
            //input for price with prefix icon the TTC symbol
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: priceController,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                ),
                //white square border, with rounded corners, golden on focus
                decoration: InputDecoration(
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/logo-ttc.png',
                        width: 25,
                        height: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'TTC',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: goldcolor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Text(
                translation(context).offer_expires_in_text + ' ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 5),
            //text "Las ofertas dejaran de mostrarse en la fecha de expiracion"
            Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Text(
                  translation(context).offer_wont_show_text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                  ),
                )),

            SizedBox(height: 10),
            //disabled input for disabled_date with suffix icon
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: TextField(
                  //forbid editing , but allow to click on suffix icon
                  enabled: false,
                  controller: expire_dateController,
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
              ),
            ),
            //datepicker for expire_date
            SizedBox(height: 5),

            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: goldcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  onPressed: (isdisabled)
                      ? null
                      : () {
                          GlobalTools().showWaitDialog(
                              waitText: translation(context).please_wait);
                          Provider.of<UiProvider>(context, listen: false)
                              .selectedMainMenu = 0; // Rein
                          var amount = double.parse(priceController.text);
                          var ndata = {
                            'id': widget.offer.id,
                            'price': amount,
                            'title': titleController.text,
                            'subTitle': subtitleController.text,
                            'expire_date': expire_dateController.text,
                            'description': descriptionController.text,
                          };
                          print(ndata);
                          if (haschanged) {
                            ndata['imageUrl'] = imageFile;
                            HttpApi.postWithImage(
                                '/post/update', ndata, imageFile)
                                .then((value) {
                              if (value['status'] == 'success') {
                                GlobalTools().closeDialog();
                                //Navigator.pushNamed(context, '/success');
                                NavigationService.replaceRemoveTo(
                                    Flurorouter.confirmationRoute);
                              }
                            }).catchError((error) {
                              print(error);
                              print(error.data);
                            });
                          } else {
                            HttpApi.postJson('/post/update', ndata)
                                .then((value) {
                              if (value['status'] == 'success') {
                                GlobalTools().closeDialog();
                                //Navigator.pushNamed(context, '/success');
                                NavigationService.replaceRemoveTo(
                                    Flurorouter.confirmationRoute);
                              }
                            }).catchError((error) {
                              print(error);

                            });
                          }
                        },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    //align center
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translation(context).save_offer_text,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 40),
          ])),
    );
  }

  Widget goldenBox() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      //box is a quare, with dashed golden border
      child: DottedBorder(
        color: goldcolor,
        strokeWidth: 1,
        dashPattern: [5, 5],
        child: Container(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Text(
                translation(context).upload_image_option,
                style: TextStyle(
                  color: goldcolor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            )),
      ),
    );
  }

  void uploadImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        haschanged = true;
        imagepath = pickedFile.path;
        //create fileFile(_imageFileList![index].path),
        imageFile = File(pickedFile.path);
        //send the image to the server
        //update the image url

      });
    } else {
      print('No image selected.');
    }
  }



  Widget imageBox() {
    //return a container with the image just selected with image_picker
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: DottedBorder(
          color: goldcolor,
          strokeWidth: 1,
          dashPattern: [5, 5],
          child: Container(
              height: 200,
              width: double.infinity,
              child: Center(
                child: imagepreview(),)
          )),

    );
  }
  Widget imagepreview(){
    if( imagepath == '' || haschanged) {
      return Image.file(imageFile!, fit: BoxFit.cover,);
    }else{
      return Image.network(url);
    }

  }

  void showToast(String s) {}

  void handlesubmit() {}
}
