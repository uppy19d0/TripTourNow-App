import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/theme.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/http/auth_response.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/WaitProgress.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/custom_style.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/size.dart';
import '../../../utils/strings.dart';
import '../../../widgets/button_widget/primary_button.dart';
import '../../../widgets/input_widget/primary_input_widget.dart';
import '../../../controller/kyc_from_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final controller = Get.put(KYCFromController());

class UserVerification extends StatefulWidget {
  const UserVerification({Key? key}) : super(key: key);

  @override
  State<UserVerification> createState() => _UserVerificationState();
}

class _UserVerificationState extends State<UserVerification> {
  final signUpFormKey = GlobalKey<FormState>();
  String imagepathFront = '';
  String imagepathBack = '';
  File? imageFileFront;
  File? imageFileBack;

  late User user;
  bool isVerified = false;
  bool isVerificationInProgress = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<AuthProvider>(context, listen: false).user!;

    //isAuthenticated;
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(isVerificationInProgress){
        Provider.of<AuthProvider>(context, listen: false).isAuthenticated().then((value){
          setState(() {
            user = Provider.of<AuthProvider>(context, listen: false).user!;
            isVerified = value;
            isVerificationInProgress = false;
            debugPrint("user: ${user.verificationStatus}");
          });
        });
      }

    });


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            NavigationService.replaceRemoveTo(
                Flurorouter.myAccountRoute);      },
        ),
        backgroundColor: Colors.black,
        title: Text(translation(context).identity_verification_text),
      ),
      body: _bodyWidget(context),

    );
  }
  _bodyWidget(BuildContext context) {

    final controller = Get.put(KYCFromController());
      return Container(
        width: MediaQuery. of(context). size. width,
        color: backgroundcolor,
          child:ListView( padding: EdgeInsets.symmetric( horizontal: 40),
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(height: 20),
            if(isVerificationInProgress)...[
              Container( margin: EdgeInsets.only(top: 40), child: WaitProgress( text: "Verificando estatus del usuario",))
            ] else ...[

              if(user.verificationStatus == "unverified")...[
                Text(
                  translation(context).provide_images_to_verify_text,
                  style: TextStyle(
                    color: goldcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20,),
                _uploadImageWidget(context),
                _buttonWidget(context),
              ] else if(user.verificationStatus == "verified") ...[
                Text(
                  translation(context).account_verificated_text,
                  style: TextStyle(
                    color: goldcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ] else ...[
                Text(
                  translation(context).account_process_verification_text,
                  style: TextStyle(
                    color: goldcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],

            ]
        ],
      ));

  }

  _uploadImageWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainCenter,
      children: [
        Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            Expanded(
              child: DottedBorder(
                dashPattern: const [6, 4],
                strokeWidth: 2,
                color: CustomColor.borderColor,
                child: SizedBox(
                  height: Dimensions.heightSize * 8.3,
                  child: GestureDetector(
                    onTap: () {
                     // _openImageSourceOptions(context);
                      uploadImage(true);
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: mainCenter,
                        children: [
                          SvgPicture.asset('assets/icons/front_part.svg'),
                          addVerticalSpace(
                            Dimensions.heightSize * 0.7,
                          ),
                          Text(
                            Strings.frontPart,
                            style: CustomStyle.borderColorText,
                          ),
                        ],
                      ),
                    ),
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
                  child: GestureDetector(
                    onTap: () {
                     // _openImageSourceOptions(context);
                      uploadImage(false); // False es back image
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: mainCenter,
                        crossAxisAlignment: crossCenter,
                        children: [
                          SvgPicture.asset('assets/icons/back_part.svg'),
                          addVerticalSpace(
                            Dimensions.heightSize * 0.7,
                          ),
                          Text(
                            Strings.backPart,
                            style: CustomStyle.borderColorText,
                          ),
                        ],
                      ),
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
          translation(context).upload_photo_idnumber_text,
          style: CustomStyle.smallestTExtStyle,
        ),
        addVerticalSpace(Dimensions.heightSize)
      ],
    );
  }

  void uploadImage(bool type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if(type){
          imagepathFront = pickedFile.path;
          imageFileFront = File(pickedFile.path);
        }else{
          imagepathBack = pickedFile.path;
          imageFileBack = File(pickedFile.path);
        }

        //send the image to the server
      });
    } else {
      print('No image selected.');
    }
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: PrimaryButtonWidget(
        text: translation(context).continue_text,
        onPressed: () {
          NavigationService.replaceRemoveTo(  Flurorouter.facelockRoute);
          // if(imageFileFront != null && imageFileBack != null){
          //   subirImagenesDeConfirmacion();
          // }else{
          //   debugPrint("Falta las imagenes");
          // }

        },
      ),
    );
  }



  Future<void> subirImagenesDeConfirmacion() async {
    debugPrint("subirImagenesDeConfirmacion");
    Map<String, dynamic> ndata = { };
    if(imageFileFront != null && imageFileBack != null){
      ndata['imageUrl'] = imageFileFront;
      ndata['imageUrl'] = imageFileBack;
    }
    HttpApi.postWithTwoImage('/upload_verification_1', ndata, imageFileFront!, imageFileBack!).then((value) {
      debugPrint(value.toString());
      if(value['status'] == 'success'){
        //NavigationService.replaceRemoveTo( Flurorouter.offerConfirmationRoute);
        NavigationService.replaceRemoveTo(  Flurorouter.facelockRoute);
        //debugPrint("Subio las imagenes bien");
      }

    }).catchError((error) {
      print(error);
      print(error.data);

    });
  }


}
