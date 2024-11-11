import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controller/virtual_card_controller/virtual_card_controller.dart';
import '../../../../generated/assets.dart';
import '../../../../router/router.dart';
import '../../../../services/navigation_service.dart';
import '../../../../shared/MyAppBar.dart';
import '../../../../theme.dart';
import '../../../../utils/custom_color.dart';
import '../../../../utils/custom_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/size.dart';
import '../../../../utils/strings.dart';
import '../../../../widgets/transaction_widget/recen_transaction_widget.dart';


class VirtualCardScreen extends StatelessWidget {
  VirtualCardScreen({super.key});
  final controller = Get.put(VirtualCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //Get.back();
            NavigationService.navigateTo(Flurorouter.homeRoute);
          },
        ),
        backgroundColor: Colors.black,
        //ttc logo
        title:  Text("Tarjeta Virtual"),
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Container( color:backgroundcolor,child: ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 40,
      ),
      children: [
        SizedBox(height: 20,),
        _cardWidget(context),
        _recentTransWidget(context),
      ],),
    );
  }

  _cardWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.34,
      padding: EdgeInsets.symmetric(
        horizontal: 50,
        vertical: Dimensions.defaultPaddingSize,
      ),
      decoration: BoxDecoration(
        image:  DecorationImage(
            image: AssetImage('assets/BG/VirtualCard.png'), fit: BoxFit.cover),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 1.5),
          topRight: Radius.circular(Dimensions.radius * 1.5),
          bottomLeft: Radius.circular(Dimensions.radius * 1.5),
          bottomRight: Radius.circular(Dimensions.radius * 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addVerticalSpace(Dimensions.heightSize * 5),
          Text(
            "9864 1326 7135 3126",
            style: TextStyle(
              fontFamily: "AgencyFB",
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          addVerticalSpace(Dimensions.heightSize * 1.8),
          Row(
            children: [
              Column(
                mainAxisAlignment: mainCenter,
                children: [
                  Text(
                    '09/25',
                    style: TextStyle(
                      fontFamily: "AgencyFB",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: greycolor,
                  ),),
                  Text(
                    Strings.expiryDate,
                    style: TextStyle(
                      fontFamily: "AgencyFB",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: greycolor,
                    ),
                  ),
                ],
              ),
              addHorizontalSpace(Dimensions.widthSize * 6),
              Column(
                mainAxisAlignment: mainCenter,
                children: [
                  Text(
                    '123' ,
                    style: TextStyle(
                      fontFamily: "AgencyFB",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: greycolor,
                    ),
                  ),
                  Text(
                    'CVV',
                    style: TextStyle(
                      fontFamily: "AgencyFB",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: greycolor,
                  ),)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  _recentTransWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            Dimensions.radius * 1.5,
          ),
          topRight: Radius.circular(
            Dimensions.radius * 1.5,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            addVerticalSpace(10),
            Text(
              'Transacciones Recientes',
              style: TextStyle(
                fontFamily: "AgencyFB",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: goldcolor  ,
              ),
            ),
            addVerticalSpace(Dimensions.heightSize),
            const TransactionWidget(
              amount: '150.0 TTC',
              img: 'assets/icons/send.svg',
              title: 'Envio a Amigo',
              subTitle: Strings.tN20236,
              dateText: Strings.firstOct,
            ),
            addVerticalSpace(
              Dimensions.heightSize,
            ),
            const TransactionWidget(
              amount: Strings.usd269,
              img: 'assets/icons/receive.svg',
              title: 'Compra con TTC',
              subTitle: Strings.tN20236,
              dateText: Strings.sep29,
            ),
            addVerticalSpace(
              Dimensions.heightSize,
            ),
          ],
        ),
      ),
    );
  }
}
