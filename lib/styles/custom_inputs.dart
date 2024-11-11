import 'package:flutter/material.dart';

import '../theme.dart';


class CustonImputs{

  static InputDecoration accountInput( {String hint = "", String label = ""})=> InputDecoration(
    filled: true,
    fillColor: Colors.black,
    contentPadding: EdgeInsets.all(12),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: white),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: goldcolor),
    ),
    enabledBorder: const OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey)
    ),
    errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: const Color(0xFFcc3333))
    ),
    //Color(0xFF336699)
    hintText: hint,
    labelText: label,
    //prefixIcon: Icon( icon, color: Colors.grey ),
    labelStyle: const TextStyle(  color: Colors.white ),
    hintStyle:  const TextStyle( color: Colors.white, ),
    counterText: "",


  );

}