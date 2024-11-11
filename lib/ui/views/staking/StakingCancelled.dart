import 'package:flutter/material.dart';

import '../../../class/language_constants.dart';

class StakingCancelled extends StatelessWidget {
  const StakingCancelled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(translation(context).staking_cancelled_text),
    );
  }
}
