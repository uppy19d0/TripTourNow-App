import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/ui/views/main/PassReset.dart';
import 'package:trip_tour_coin/ui/views/main/my_account_view.dart';

import '../../../class/language_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';
import '../../layouts/core_layaout.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UiProvider>(context, listen: false).setAppBar(
        appBarBackBtn: false,
        appBarTitle: translation(context).my_account_text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    String? fullname = "";
    String? email = "";
    fullname = authProv.user?.fullname;
    email = authProv.user?.email;
    return CoreLayout(
        child: Container(
            color: backgroundcolor,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: ListView(
              children: [
                ListTile(
                  //remove the default padding
                  contentPadding: EdgeInsets.all(0),
                  leading: Container(
                    width: 50,
                    height: 50,
                    child: SvgPicture.asset('assets/icons/micuenta-perfil.svg',
                        color: goldcolor, semanticsLabel: 'Label'),
                  ),
                  title:     Text(
                      overflow: TextOverflow.ellipsis,
                      fullname!,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: white)),
                  subtitle:         Text(
                      overflow: TextOverflow.ellipsis,
                      email!,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: white)) ,

                ),

                Divider(color:white),
                ElevatedButton(
                    onPressed: () {
                      //navigation service push
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyAccountView()),
                      );
                    },
                    //make it transparent
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: ListTile(
                      //remove the default padding
                      contentPadding: EdgeInsets.all(0),
                      leading: Container(
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset(
                            'assets/icons/micuenta-perfil.svg',
                            ),
                      ),
                      title: Text(translation(context).settings_text,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: white)),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: white, size: 20),
                    )
                    ,
                ),
                Divider(color:white),
                ElevatedButton(
                  onPressed: () {
                    //navigation service push
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PassResetView()),
                    );
                  },
                  //make it transparent
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: ListTile(
                    //remove the default padding
                    contentPadding: EdgeInsets.all(0),
                    leading: Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        'assets/icons/micuenta-contrasena.svg',
                      ),
                    ),
                    title: Text(translation(context).my_account_change_password,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: white)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: white, size: 20),
                  )
                  ,
                ),
                Divider(color:white),

                ElevatedButton(
                  onPressed: () {
                    NavigationService.replaceRemoveTo(
                        Flurorouter.userVerificationRoute);
                    
                  },
                  //make it transparent
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: ListTile(
                    //remove the default padding
                    contentPadding: EdgeInsets.all(0),
                    leading: Container(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.verified_user, color: white),
                    ),
                    title: Text(translation(context).identity_verification_text,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: white)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: white, size: 20),
                  )
                  ,
                ),
                Divider(color:white),
                ElevatedButton(
                  onPressed: () {
                    authProv.logout();

                  },
                  //make it transparent
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: ListTile(
                    //remove the default padding
                    contentPadding: EdgeInsets.all(0),
                    leading: Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        'assets/icons/micuenta-salir.svg',
                      ),
                    ),
                    title: Text(translation(context).my_account_logout,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: white)),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: white, size: 20),
                  )
                  ,
                ),
                Divider(color:white),
                Container(
                  alignment: Alignment.center,
                    margin: const EdgeInsets.only(  top: 20,bottom: 20),
                    child: Text("Version 1.0.3", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: primaryColor ))
                )
              ],
            )));
  }
}
