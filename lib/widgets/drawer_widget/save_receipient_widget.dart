import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_tour_coin/theme.dart';

import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';

class SaveReceipientWidget extends StatelessWidget {
  const SaveReceipientWidget(
      {super.key, required this.img, required this.name,required this.bottom, required this.gmail});
  final String img, name, gmail;
  final Widget bottom;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child:Container(
        color: Colors.black,
        margin: EdgeInsets.zero,
        child: Container(
            padding: EdgeInsets.only(
                bottom: Dimensions.defaultPaddingSize * 0.1,
                right: Dimensions.defaultPaddingSize * 0.4),
            height: 70,
            child: ListTile(
              leading: Image.asset(img, height: 50, width: 50),
              title: Text(
                name,
                style: TextStyle(

                    fontSize: 18,
                    color: goldcolor,
                    fontWeight: FontWeight.w500)
              ),
              trailing: bottom,
              subtitle: Padding(
                padding:  EdgeInsets.only(top: 0),
                child: Text(
                  gmail,
                  style: TextStyle(
                      fontSize: 11,
                      color: white,
                      fontWeight: FontWeight.w500),
              ),
            )),
      ),)
    );
  }
}
