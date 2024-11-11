
import 'package:flutter/material.dart';
import 'package:trip_tour_coin/shared/global_dialog.dart';

import '../api/HttpApi.dart';
import '../class/language_constants.dart';
import '../models/http/auth_response.dart';
import '../models/http/error_http.dart';
import '../router/router.dart';
import '../services/local_storage.dart';
import '../services/navigation_service.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  User? user;
  AuthStatus authStatus = AuthStatus.notAuthenticated;
  List<MyCondo> myCondos = [];
  MyCondo? myCondo;
  Data? userData;
  Notifications? condoNotifications;
  Tickets? tickets;

  int _selectedMainMenu = 0;

  int get selectedMainMenu => _selectedMainMenu;

  set selectedMainMenu(int value) {
    _selectedMainMenu = value;
  }

  AuthProvider() {
    debugPrint("Se llama AuthProvider");
    isAuthenticated().then((value) => print(value));
  }
  Future<bool> isAuthenticated() async {
    debugPrint("isAuthenticated");
    final token = LocalStorage.prefs.getString('token');
    bool flag = false;

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return flag;
    }

    flag = await HttpApi.httpGet('/getUser').then((json) {
      print(json);

      final authReponse = AuthResponse.fromJson(json);

      LocalStorage.prefs.setString('token', authReponse.token);
      user = authReponse.auth;
      authStatus = AuthStatus.authenticated;
      notifyListeners();

      return true;
    }).catchError((e) {
      //debugPrint(e.data);
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      user = null;
      notifyListeners();
      return false;
    });
    return flag;
  }

  login(String email, String password) {
    final data = {'email': email, 'password': password};
    //print("lOGIN $data");

    GlobalTools().showWaitDialog(
        waitText: 'Iniciando sesión');
    LocalStorage.prefs.setString('token', '');
    HttpApi.postJson('/login', data).then((json) {

      print('loguea');
      print(json);
      final authResponse = AuthResponse.fromJson(json);

      user = authResponse.auth;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigationService.replaceRemoveTo(Flurorouter.homeRoute);
      HttpApi.configureDio();
      notifyListeners();
      GlobalTools().closeDialog();
    }).catchError((e) {
      GlobalTools().closeDialog();
      print(e);
      //show snackbar red , usuario o contraseña incorrectos
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
          SnackBar(
            content: Text('Datos incorrectos',
                textAlign: TextAlign.center),
            backgroundColor: Colors.redAccent,
          )
      );
      if (e is ErrorHttp) {

        print(e.data);


      }else{
        print(e);
      }
      print('error en: ${e}');
    });
  }

  Register(Map<String, String> nData) {
    GlobalTools().showWaitDialog(
        waitText: 'Registrando');

    HttpApi.postJson('/register', nData).then((json) {
      print(json);
      GlobalTools().closeDialog();
      //json['authorisation']['token']
      String token = json['authorisation']['token'];
      LocalStorage.prefs.setString('token', json['authorisation']['token']);
      print(token);
      authStatus = AuthStatus.authenticated;
      user = User.fromJson(json['user']);
      HttpApi.configureDio();
      notifyListeners();
      GlobalTools().closeDialog();
      NavigationService.replaceRemoveTo(Flurorouter.verifyMailRoute);

    }).catchError((e) {
      //close dialog
      GlobalTools().closeDialog();
      ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
          .showSnackBar(
          SnackBar(
            content: Text('Algo ha salido mal, intenta de nuevo',
                textAlign: TextAlign.center),
            backgroundColor: Colors.redAccent,
          )
      );
      print(e);

    });
  }

  logout() {
    LocalStorage.prefs.setString('token', '');
    user = null;
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
    //NavigationService.replaceTo(Flurorouter.loginRoute);
  }
}
