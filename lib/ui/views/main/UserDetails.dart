import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:trip_tour_coin/models/http/auth_response.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/http/error_http.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/custom_style.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/size.dart';
import '../../../utils/strings.dart';
import 'buywithcard.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;
  const UserDetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {

  bool haschangedpercentaje = false;
  //form textcontroller for the porcentaje

  TextEditingController ctrlPercentaje= TextEditingController(text:'0');
  double cantidadRetirar = 100;
  double porcentaje = 0;
  double cantidadRecibir = 100;
  double resultado = 0;


  @override
  void initState() {
    // TODO: implement initState
    //print user
    print(widget.user);
    //setlocalization
    //get admin/user/{id}
    HttpApi.httpGet('/admin/user/${widget.user.id}').then((json) {
      print(json);
      setState(() {
        //the if the percentaje is null or 0 set it to 0, parse it from json string to double

        ctrlPercentaje.text = json['data']['percentaje'].toString();
      });
    }).catchError((e) {
      //show snackbar red , usuario o contraseña incorrectos
      if (e is ErrorHttp) {
        print(e.data);
        ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
            .showSnackBar(SnackBar(
          content: Text(translation(context).error_text, textAlign: TextAlign.center),
          backgroundColor: Colors.redAccent,
        ));
      }
      print('error en: ${e}');
    });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).user_details_text, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w100)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () =>
              {NavigationService.replaceRemoveTo(Flurorouter.usersRoute)},
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo(
            uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      body: _bodyWidget(context),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Container(
      color: backgroundcolor,
      height: double.infinity,
      width: double.infinity,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          SizedBox(height: 20),
          //Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translation(context).status_text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: white),
              ),
          //badge status bordered with color
              if(widget.user.verificationStatus=='pending')
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: goldcolor),
                ),
                child: Text(
                  translation(context).pending_text,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: goldcolor),
                ),
              ),
              if(widget.user.verificationStatus=='unverified')
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Text(
                    translation(context).unverified_text,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.red),
                  ),
                ),
              if(widget.user.verificationStatus=='verified')
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Text(
                    translation(context).verified_text,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.green),
                  ),
                ),

            ],
          ),
          SizedBox(height: 20),
          if((widget.user.verificationStatus=='verified' || widget.user.verificationStatus=='pending') )
          //image selfie
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(widget.user.selfie),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if(widget.user.verificationStatus=='unverified')
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: Image.asset('assets/user.png').image,

                ),
              ),
            ),
SizedBox(height: 20),
          //row with user picture and name
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.firstName + ' ' + widget.user.lastname,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: goldcolor),
                  ),
                  Text(
                    widget.user.email,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                  //dni
                  Text(
                    widget.user.dni,
                    style: TextStyle(
                      fontSize: 14,
                      color: white,
                    ),
                  ),
                  //phone, country and birthday
                  Text(
                    widget.user.phone,
                    style: TextStyle(
                      fontSize: 14,
                      color: white,
                    ),
                  ),
                  Text(
                    widget.user.country +
                        ', ' +
                        DateFormat('MM/dd', 'es').format(widget.user.birthday),
                    style: TextStyle(
                      fontSize: 14,
                      color: white,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Pictures(context),
        ],
      ),
    );
  }

  Widget Pictures(context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 20,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              translation(context).identity_verification_text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: goldcolor,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              Expanded(
                child: DottedBorder(
                  dashPattern: const [6, 4],
                  strokeWidth: 2,
                  color: goldcolor,
                  child: SizedBox(
                    height: Dimensions.heightSize * 8.3,
                    child: Stack(
                      children: [
                        if(widget.user.verificationStatus=='unverified')
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/BG/idcard.png'),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              '',
                              height: Dimensions.heightSize * 1.4,
                            ),
                          ),
                        ),
                        if(widget.user.verificationStatus=='verified' || widget.user.verificationStatus=='pending')
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.user.id_front),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              '',
                              height: Dimensions.heightSize * 1.4,
                            ),
                          ),
                        ),
                        if(widget.user.verificationStatus=='verified' || widget.user.verificationStatus=='pending')
                        const Positioned(
                          right: 5,
                          top: 15,
                          child: CircleAvatar(
                            radius: 11,
                            backgroundColor: Color(0xff00B654),
                            child: Icon(
                              Icons.check,
                              color: CustomColor.whiteColor,
                              size: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              addHorizontalSpace(
                Dimensions.widthSize,
              ),
              Expanded(
                child: DottedBorder(
                  color: CustomColor.borderColor,
                  dashPattern: const [8, 4],
                  strokeWidth: 2,
                  child: SizedBox(
                    height: Dimensions.heightSize * 8.3,
                    child: Center(
                      child: Stack(
                        children: [
                          if(widget.user.verificationStatus=='unverified')
                            Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/BG/idcard.png'),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(
                                'assets/images/camera.svg',
                                height: Dimensions.heightSize * 1.4,
                              ),
                            ),
                          ),
                          if(widget.user.verificationStatus=='verified' || widget.user.verificationStatus=='pending')
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(widget.user.id_back),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: SvgPicture.asset(
                                  '',
                                  height: Dimensions.heightSize * 1.4,
                                ),
                              ),
                            ),
                          if(widget.user.verificationStatus=='verified' || widget.user.verificationStatus=='pending')

                            const Positioned(
                            right: 5,
                            top: 15,
                            child: CircleAvatar(
                              radius: 11,
                              backgroundColor: Color(0xff00B654),
                              child: Icon(
                                Icons.check,
                                color: CustomColor.whiteColor,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          addVerticalSpace(
            Dimensions.heightSize * 0.5,
          ),
          Text(
            translation(context).id_number_text,
            style: CustomStyle.smallestTExtStyle,
          ),
          SizedBox(height: 15),
          Container(
            child: Center(
                child: Text(
              translation(context).ttc_address_text,
              style: TextStyle(
                  color: goldcolor, fontSize: 18, fontWeight: FontWeight.bold),
            )),
          ),
          SizedBox(height: 0),
          Row(children: [
            //add a text that can be multiline
            Expanded(
              child: Text(
                widget.user!.address,
                style: TextStyle(color: white, fontSize: 16),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Center(
                child: QrImage(
                  backgroundColor: white,
                  data: widget.user!.address,
                  version: QrVersions.auto,
                  size: 100.0,
                ),
              ),
            ),
          ]),
          //white text Actions:
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              translation(context).actions_text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: white,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 0),

          Row(
            children: [
              // red outlined button small with icon for "Block User"
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 00,
                ),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red, side: BorderSide(color: Colors.red, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(translation(context).block_access_text)),
              ),
              SizedBox(
                width: 10,
              ),
              //green outlined button small with icon for "Verfify User"
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 20,
                ),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green, side: BorderSide(color: Colors.green, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      //httpApi
                      GlobalTools().showWaitDialog(
                          waitText: translation(context).updating_offer_percentaje_text);
                      //call updateOffer from api
                      final data = {'id': widget.user.id, 'status': 'verified'};

                      HttpApi.postJson('/admin/verificationStatus', data)
                          .then((json) {
                        NavigationService.replaceRemoveTo(
                            Flurorouter.usersRoute);
                        //close dialog
                        GlobalTools().closeDialog();
                      }).catchError((e) {
                        GlobalTools().closeDialog();
                        //show snackbar red , usuario o contraseña incorrectos

                        if (e is ErrorHttp) {
                          print(e.data);
                          ScaffoldMessenger.of(NavigationService
                                  .navigatorKey.currentContext!)
                              .showSnackBar(SnackBar(
                            content: Text(translation(context).error_text,
                                textAlign: TextAlign.center),
                            backgroundColor: Colors.redAccent,
                          ));
                        }
                        print('error en: ${e}');
                      });
                    },
                    child: Text(translation(context).verify_text)),
              ),
     
            ],
          ),
          SizedBox(height: 20,),
          (widget.user.type=='seller')?Container(
            child:Column(
              //white text w100% for "este usuario es un vendedor, desea ajustar el porcentaje que se aplicara a sus retiros.
              children :[
              Text(
                translation(context).this_user_is_text + " " + translation(context).seller_text + " " + translation(context).userDetails_want_adjust_percentaje_text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: white,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10,),
                Container(
                  child: TextFormField(
                    //color white
                    style: TextStyle(color: white,fontSize: 16),
                    controller: ctrlPercentaje,
                    //golden borders
                    onChanged: (value){
                      //VALIDATE THAT VALUE CANT BE MORE THAN 100
                      //if value is more than 100, set value to 100
                      if(int.parse(value)>100){
                        ctrlPercentaje.text = '100';
                        return;
                      }
                      print('el monto es');
                      print(value);
                      //if value is null or 0, set the value to

                      setState(() {
                        if(value==''){
                          porcentaje = 0;
                        }else{
                          porcentaje = int.parse(value) / 100;
                        }

                         resultado = cantidadRetirar - (cantidadRetirar * porcentaje);
                        haschangedpercentaje = true;
                      });
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.percent,color: white,),

                          SizedBox(width: 10,),
                        ],
                      ),
                      hintStyle: TextStyle(color: white),
                      //use assets/logo-ttc.png as prefix icon
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),


                  ),
                ),
                SizedBox(height: 10,),
                //text al retirar 100 TTC este usuario recibira 90 TTC
                (ctrlPercentaje.text=='0' || ctrlPercentaje.text=='')?
                Text(
                  translation(context).userDetails_for_example_text + ' 100 TTC',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                    color: white,
                  ),
                  textAlign: TextAlign.left,
                ):
                Text(
                  translation(context).userDetails_for_example_text + ' ${resultado} TTC',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                    color: white,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity  ,
                  child:
                ElevatedButton(
                  onPressed:() {
                    if(ctrlPercentaje.text == '' || ctrlPercentaje.text == null){
                      //red snackbar with text, "El monto no puede ser 0 o vacio" but dont use globaltools
                      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                          .showSnackBar(
                          SnackBar(
                            content: Text(
                                translation(context).percentaje_greater_zero_text,
                                textAlign: TextAlign.center),
                            backgroundColor: Colors.redAccent,
                          )
                      );

                      return;
                    }
                    double amount= double.parse(ctrlPercentaje.text);
                    int userid = widget.user.id;
                    var nData = {
                      'percentaje': amount,
                      'userid': userid,
                    };
                  //httpapi postjson
                    HttpApi.postJson('/admin/update-percentage', nData)
                        .then((json) {
                      NavigationService.replaceRemoveTo(
                          Flurorouter.usersRoute);
                      //close dialog
                      GlobalTools().closeDialog();
                    }).catchError((e) {
                      GlobalTools().closeDialog();
                      //show snackbar red , usuario o contraseña incorrectos

                      if (e is ErrorHttp) {
                        print(e.data);
                        ScaffoldMessenger.of(NavigationService
                            .navigatorKey.currentContext!)
                            .showSnackBar(SnackBar(
                          content: Text(translation(context).error_text,
                              textAlign: TextAlign.center),
                          backgroundColor: Colors.redAccent,
                        ));
                      }
                      print('error en: ${e}');
                    });

                    print(nData);
                    //if amount is 0 or null show snackbar. red

                    GlobalTools().showWaitDialog(
                        waitText: translation(context).please_wait);
                    Provider.of<UiProvider>(context, listen: false)
                        .selectedMainMenu = 0; // Reinicia el menu
                    //push buywithcard
                    //navigator.push
                    //post to admin/update-percentaje


                  },
                  child: Text(translation(context).save_changes_text,style:TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:Colors.black,
                  )),

                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: greycolor, backgroundColor: goldcolor,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),

                  ),),
                )]),
          ):Container(),
          //textinput for percentaje
          SizedBox(height:10),


        ],
      ),
    );
  }
}
