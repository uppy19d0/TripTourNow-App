import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/custom_color.dart';
import '../../utils/custom_style.dart';
import '../../utils/dimensions.dart';

class PrimaryInputWidget extends StatefulWidget {
  final String labelText;
  final String hintText;
  final int maxLines;
  final Widget? suffix;
  final Widget? preffix;
  final TextEditingController controller;
  const PrimaryInputWidget({
    Key? key,
    required this.controller,
    this.maxLines = 1,
    this.suffix,
    this.preffix,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  @override
  State<PrimaryInputWidget> createState() => _PrimaryInputWidgetState();
}

class _PrimaryInputWidgetState extends State<PrimaryInputWidget> {
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
    return Container(
      alignment: Alignment.centerLeft,
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(widget.labelText,
          style: TextStyle(color: Colors.white, fontSize: 15),
          textAlign: TextAlign.start),
      SizedBox(
        height: 10,
      ),
      TextField(

        controller: widget.controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          suffixIcon: widget.suffix,
          prefix: widget.preffix,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.white),

          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
        ),
      )
    ]));
  }
}
