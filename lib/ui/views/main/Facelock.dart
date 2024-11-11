import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_tour_coin/services/navigation_service.dart';
import 'package:trip_tour_coin/theme.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../controller/entered_faceloack_controller.dart';
import '../../../controller/facelock_capture_controller.dart';
import '../../../router/router.dart';
import '../../../shared/MyAppBar.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/custom_style.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/size.dart';
import '../../../utils/strings.dart';
import '../../../widgets/button_widget/primary_button.dart';
final controller = Get.put(EnteredFacelockController());

class Facelock extends StatefulWidget {
  const Facelock({Key? key}) : super(key: key);

  @override
  State<Facelock> createState() => _FacelockState();
}

class _FacelockState extends State<Facelock> {

  final controller = Get.put(FacelockColotroller());

  File? selfie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            NavigationService.navigateTo(Flurorouter.userVerificationRoute);
          },
        ),
        backgroundColor: Colors.black,
        //ttc logo
        title:  Image.asset('assets/logo-ttc.png',height: 35,),
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Container(
      color:backgroundcolor,
        child:
        Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.defaultPaddingSize * 0.6,
      ),
      child: Column(
        mainAxisAlignment: mainCenter,
        children: [
          _textWidget(context),
          _imgWidget(context),
          _buttonWidget(context),
        ],
      ),),
    );
  }

  _textWidget(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.defaultPaddingSize * 0.6,
        vertical : Dimensions.defaultPaddingSize * 0.6,
      ),
      children: [
        Text(
          translation(context).face_verification_text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: goldcolor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )
        ),
        SizedBox(height: 10),
        Text(
          translation(context).take_a_photo_text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          )
        ),
      ],
    );
  }

  _imgWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.marginSize * 3.5,
      ),
      child: Column(
        children: [
          GestureDetector(

            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(Dimensions.marginSize * 0.3),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration:  BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: goldcolor,
                    width: 3.0,
                  ),
                  bottom: BorderSide(
                    color: goldcolor,
                    width: 3.0,
                  ),
                ),
                image: DecorationImage(
                    image: AssetImage(
                      'assets/BG/person1.png',
                    ),
                    fit: BoxFit.cover),
              ),
              child: GestureDetector(
                onTap: () {
                  ImagePicker().pickImage(source: ImageSource.camera).then((value){
                    if(value != null){
                      selfie = File(value.path);
                      setState(() { });
                      subirImagenesDeConfirmacion();
                    }
                  });
                  //_openImageSourceOptions(context);
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: CustomColor.blackColor.withOpacity(0.5),
                  child: SvgPicture.asset(
                    'assets/icons/camera.svg',
                    height: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  _buttonWidget(BuildContext context) {
    return Column(
      children: [
        PrimaryButtonWidget(
          text: translation(context).continue_text,
          onPressed: () {
            controller.onPressedconfirm();
          },
        ),
        addVerticalSpace(
          Dimensions.heightSize * 2,
        ),

      ],
    );
  }


  Future<void> subirImagenesDeConfirmacion() async {
    debugPrint("subirImagenesDeConfirmacio FACE LOCK");
    Map<String, dynamic> ndata = {};
    if (selfie != null) {
      HttpApi.postWithImageSelfie('/upload_verification_2', ndata, selfie!).then(( value) {
        debugPrint(value.toString());
        if (value['status'] == 'success') {
          //NavigationService.replaceRemoveTo( Flurorouter.offerConfirmationRoute);
          //NavigationService.replaceRemoveTo(  Flurorouter.facelockRoute);
          debugPrint("Subio las imagenes bien FACE LOCK");
        }
      }).catchError((error) {
        print(error);
        print(error.data);
      });
    }
  }


}


//
// _openImageSourceOptions(BuildContext context) {
//   showGeneralDialog(
//       barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//       barrierDismissible: true,
//       barrierColor: Colors.black.withOpacity(0.6),
//       transitionDuration: const Duration(milliseconds: 700),
//       context: context,
//       pageBuilder: (_, __, ___) {
//         return Material(
//           type: MaterialType.transparency,
//           child: Align(
//             alignment: Alignment.center,
//             child: Container(
//               height: Dimensions.heightSize * 13,
//               width: Dimensions.widthSize * 25,
//               decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(Dimensions.radius)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         child: const Icon(
//                           Icons.camera_alt,
//                           size: 40.0,
//                           color: Colors.blue,
//                         ),
//                         onTap: () {
//                           controller.chooseFromCamera();
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                       Text(
//                         'Desde Camara',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: Dimensions.smallTextSize),
//                       )
//                     ],
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         child: const Icon(
//                           Icons.photo,
//                           size: 40.0,
//                           color: Colors.green,
//                         ),
//                         onTap: () {
//                           controller.chooseFromGallery();
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                       Text(
//                         'Desde Galeria',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: Dimensions.smallTextSize),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (_, anim, __, child) {
//         return SlideTransition(
//           position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
//               .animate(anim),
//           child: child,
//         );
//       });
// }
