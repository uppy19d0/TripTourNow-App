import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';

class PasswordInputWidget extends StatefulWidget {
  final String labelText;
  final String hintText;
  final int maxLines;
  final Icon? prefixIcon;
  final TextEditingController controller;
  const PasswordInputWidget({
    Key? key,
    required this.controller,
    this.maxLines = 1,
    this.prefixIcon,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  @override
  State<PasswordInputWidget> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<PasswordInputWidget> {
  FocusNode? focusNode;
  bool isVisibility = true;
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
            obscureText: isVisibility,
            textInputAction: TextInputAction.next,
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
              suffixIcon: Padding(
                padding:
                    EdgeInsets.only(right: Dimensions.defaultPaddingSize * 0.3),
                child: IconButton(
                  icon: Icon(
                    isVisibility == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: focusNode!.hasFocus
                        ? CustomColor.primaryColor
                        : CustomColor.borderColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isVisibility = !isVisibility;
                    });
                  },
                ),
              ),
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
                  )),
              contentPadding: EdgeInsets.only(
                left: Dimensions.widthSize * 1,
                top: Dimensions.heightSize * 0.4,
                bottom: Dimensions.heightSize * 0.4,
              ),
            ),
          ),
        )
      ],
    );
  }
}
