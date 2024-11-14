import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';

// ignore: must_be_immutable
class DashboardAppBar extends StatelessWidget {
  @override
  final Size preferredSize;

  final String title;
  List<Widget>? actions;
  final Widget ledeaing;
  final bool? centerTitle;
  final double elevation;

  DashboardAppBar({
    Key? key,
    required this.ledeaing,
    required this.title,
    this.elevation = 0,
    this.actions,
    this.centerTitle = true,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: ledeaing,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: CustomColor.whiteColor,
          fontSize: Dimensions.extraLargeTextSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevation: elevation,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: CustomColor.transparentColor,
    );
  }
}
