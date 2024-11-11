import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFCDB054);//gold
const Color secondaryColor = Color(0xFFF3F3F3);
const Color thirdColor = Color(0xFF8BC63F); //green
const Color fourthColor = Color(0xFF2abdc2);
const int textColor = 0xFF395265;
const Color white = Color(0xFFFFFFFF);
const int grayText = 0xFF415263;
const Color goldcolor = Color(0xFFCDB054);
const Color greycolor = Color(0xFF0B0B0B);
const Color backgroundcolor = Color(0xFF222222);
const Color btcorange = Color(0xFFF2A900);
//lightorange
const Color lightorange = Color(0xFFFFB27F);


//lightgold
const Color lightgold = Color(0xFFD8B666);
ThemeData customTheme = new ThemeData(
  primaryColor: primaryColor,
    textTheme: TextTheme(

      labelLarge: TextStyle(
        fontWeight: FontWeight.normal,
          fontSize: 16,
        fontFamily: "Monserrat",
        color:primaryColor,
      )
    ),
    appBarTheme: AppBarTheme(
        centerTitle: true
    ),
    fontFamily: 'Montserrat',

    primarySwatch: MaterialColor(0xFF4178B5, {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    })
);



class CustomTheme {
  static ThemeData get darkTheme { //1
    return ThemeData( //2
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],



        // Define la Familia de fuente por defecto
        fontFamily: 'Montserrat',

        // Define el TextTheme por defecto. Usa esto para espicificar el estilo de texto por defecto
        // para cabeceras, títulos, cuerpos de texto, y más.
        textTheme: TextTheme(
            displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            labelLarge: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              fontFamily: "Monserrat",
              color:primaryColor,
            )

        ),

        appBarTheme: AppBarTheme(
            centerTitle: true
        ),
        scrollbarTheme: ScrollbarThemeData().copyWith(
            thumbColor: MaterialStateProperty.all(
                Colors.grey.withOpacity(0.5)
            )
        )
    );
  }

}