// import 'dart:convert';
// import 'dart:io' show Platform;  //at the top
// import 'package:canabay_condos/services/user.service.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/User.dart';
// import '../utils/CustomException.dart';
// import '../utils/GlobalContext.dart';
// import 'base.service.dart';
//
//
//
//
//
//
//
// class AuthService {
//
//   Future saveUserLocaly(user) async{
//     final local = await SharedPreferences.getInstance();
//     await local.setString('user', jsonEncode(user));
//   }
//
//   Future _saveLocalUser(Map<String, dynamic> user) async {
//     final local = await SharedPreferences.getInstance();
//
//     local.setString('video', user['data']['video']);
//     local.setString('manuals', user['data']['manuals']);
//     local.setString('user', jsonEncode(user['auth']));
//     local.setString('token', jsonEncode(user['token']));
//     local.setBool('isLogged', true);
//   }
//
//   Future<String?> getToken() async {
//     final local = await SharedPreferences.getInstance();
//     return local.getString('token');
//   }
//
//   Future<User> login(String email, String password) async {
//
//
//
//     String os = Platform.operatingSystem; //in your code
//
//     final result = await BaseService().post('login', {'email': email, 'password': password,'firebase_token':'token','platform':os});
//     if (result.statusCode == 200) {
//       final response = jsonDecode(result.body);
//
//
//
//
//       await _saveLocalUser(response);
//
//
//       return User(response['auth']);
//     }else {
//       throw new CustomException('Email o contraseña incorrecto');
//     }
//   }
//
//   Future<User> register(Map<String, dynamic> payload) async {
//
//     final result = await BaseService().post('register', payload);
//     print(result.body.toString());
//     if(result.statusCode == 200){
//       final response = jsonDecode(result.body);
//       await _saveLocalUser(response);
//       return User(response['auth']);
//     }else {
//
//       throw new CustomException('Error al intentar registrarse, favor intentar mas tarde!');
//     }
//   }
//
//
//
//   Future forgotPassword(String email) async {
//     final result = await BaseService().post('password/email', {'email': email});
//     if(result.statusCode != 200){
//       throw new CustomException('No ha sido posible enviar el correo, favor revisar e intentar nuevamente');
//     }
//   }
//
//   Future<void> logout() async {
//
//     final local = await SharedPreferences.getInstance();
//     final isBiometricsEnabled = local.getBool('biometrics') ?? false;
//     final user = await UserService().getLocalUser();
//
//     final result = await BaseService().post('logout', {'firebase_token':''});
//
//     if (result.statusCode == 200) {
//      // final response = jsonDecode(result.body);
//
//     }
//     // Empty the shared preferences
//     if(isBiometricsEnabled){
//       await local.remove('isLogged');
//     }else {
//       await local.clear();
//     }
//
//
//     // Empty the global context
//     final BuildContext context = globalKey.currentContext!;
//
//     // Go to login
//     Navigator.pushNamedAndRemoveUntil(globalKey.currentContext!, '/', (route) => false);
//   }
// }