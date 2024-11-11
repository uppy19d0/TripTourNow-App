import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';

// ignore: must_be_immutable
class CountryPhoneWidget extends StatefulWidget {
  final String labelText;
  final String hintText;
  final int maxLines;
  final Icon? prefixIcon;
  final TextEditingController controller;
  CountryPhoneWidget({
    Key? key,
    required this.controller,
    this.maxLines = 1,
    this.prefixIcon,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  @override
  State<CountryPhoneWidget> createState() => _PrimaryInputWidgetState();

  //CountryController countryController = CountryController();
}

class _PrimaryInputWidgetState extends State<CountryPhoneWidget> {
  FocusNode? focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 52,
          margin: EdgeInsets.only(top: Dimensions.marginSize * 0.6),
          child: TextFormField(
            controller: widget.controller,
            onTap: () {
              setState(() {
                focusNode!.requestFocus();
              });
            },
            onFieldSubmitted: (value) {
              setState(() {
                focusNode!.unfocus();
              });
            },
            focusNode: focusNode,
            textAlign: TextAlign.left,
            style: CustomStyle.inputTextStyle,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: widget.labelText,
              hintText: widget.hintText,
              labelStyle: GoogleFonts.inter(
                color: focusNode!.hasFocus
                    ? CustomColor.primaryColor
                    : CustomColor.secondaryTextColor,
                fontSize: Dimensions.smallTextSize,
                fontWeight: FontWeight.w500,
              ),
              hintStyle: GoogleFonts.inter(
                color: focusNode!.hasFocus
                    ? CustomColor.primaryColor.withOpacity(0.6)
                    : CustomColor.borderColor,
                fontSize: Dimensions.smallTextSize,
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
                  borderSide: BorderSide(
                    color: focusNode!.hasFocus
                        ? CustomColor.primaryColor
                        : CustomColor.secondaryTextColor,
                    width: 2,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
                  borderSide: const BorderSide(
                    color: CustomColor.primaryColor,
                    width: 2,
                  )),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.7),
                borderSide: const BorderSide(
                  color: CustomColor.primaryColor,
                  width: 2,
                ),
              ),
              contentPadding: EdgeInsets.zero,
              prefixIcon: SizedBox(
                width: Dimensions.widthSize * 11,
                child: Row(
                  children: [
                    CountryCodePicker(
                      // flagDecoration: const BoxDecoration(
                      //   shape: BoxShape.circle,
                      // ),
                      padding: const EdgeInsets.only(left: 0),
                      initialSelection: "US",
                    ),
                    const Text(
                      '|',
                      style: TextStyle(color: CustomColor.primaryColor),
                    ),
                    addHorizontalSpace(Dimensions.widthSize * 0.1),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
