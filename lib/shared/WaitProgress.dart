
import 'package:flutter/material.dart';

import '../theme.dart';

class WaitProgress extends StatelessWidget {
  final String? text;
  final Color? color;
  const WaitProgress({Key? key, this.text, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator( color: goldcolor ),
              SizedBox( height: 20 ),
              Text(text ?? "Esperando datos", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color),)
            ],
          ),
        )
    );
  }
}
