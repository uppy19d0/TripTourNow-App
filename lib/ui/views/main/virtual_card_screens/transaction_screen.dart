import 'package:flutter/material.dart';


import '../../../../shared/MyAppBar.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/strings.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: Dimensions.defaultPaddingSize * 0.4,
        horizontal: Dimensions.defaultPaddingSize * 0.6,
      ),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

        ],
      ),
    );
  }
}
