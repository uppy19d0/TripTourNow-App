import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/ui/layouts/core_layaout.dart';

import '../../../class/language_constants.dart';
import '../../../models/Offer.dart';
import '../../../models/http/auth_response.dart';
import '../../../models/http/error_http.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';
import '../../../api/HttpApi.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'OfferDetails.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedValue = "";
  bool isloading = false;
  List<Offer> ofertas = [];
  double balance = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    //set state
    setState(() {
      isloading = true;
    });
    //await for get offers
    HttpApi.httpGet('/user/balance').then((value) {
      //balance = value['balance'].;
      //type 'int' is not a subtype of type 'double'
      balance = value['balance'].toDouble();
      //PR
      print('entra aqui');
    }).catchError((error) {
      //if error is ErrorHttp
      if (error is ErrorHttp) {

        //if error is 401
        //if error data message is unauthorized
        if (error.data['message'] == 'unauthorized') {
          //show dialog
          print('unauthorized + redireccionar a login');
          //redirect to login using flurorouter
          Flurorouter.router.navigateTo(context, '/login',
              transition: TransitionType.fadeIn);

        }
      }
    });

    HttpApi.httpGet('/posts').then((value) {
      //convert value to json
      var data = value['data'];
      for (var i = 0; i < data.length; i++) {
        print(data[i]);
        Offer offer = Offer.fromJson(data[i]);
        ofertas.add(offer); //
      }
      setState(() {
        isloading = false;
      });
    }).catchError((error) {
      print(error);
    });

    //call route user/balance
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UiProvider>(context, listen: false).setAppBar(
        appBarBackBtn: false,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    String? fullname = "";
    fullname = authProv.user?.fullname;
    User current = authProv.user!;

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return CoreLayout(
        child: isloading
            ?
            //center with background black and progress indicator gold
            Container(
                color: backgroundcolor,
                child: Center(
                  child: CircularProgressIndicator(
                    color: goldcolor,
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                color: backgroundcolor,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  //make this listview scrollable
                  padding:
                      EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 20),
                  children: [
                    Row(children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child:Text(translation(context).greeting_text + ', ' + fullname!,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),),
                      Spacer(),
                      //balance column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Saldo Disponible',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: goldcolor,  fontSize: 15, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,

                          ),
                          Text(
                            //balance with only 2 decimals
                            balance.toStringAsFixed(2) + ' ' + 'USD',
                            style:
                                Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: goldcolor, fontWeight: FontWeight.bold, fontSize: 20,
                                    ),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    if (ofertas.length > 0)
                      Container(
                        //height: 30% of the screen,
                        height: 250,
                        margin: EdgeInsets.only(top: 0),
                        child: CustomCarousel(),
                      ),
                    Container(
                      child: MenuPrincipal(user: current),
                    ),
                  ],
                ),
              ));

    //
  }

  //CustomCarousel
  Widget CustomCarousel() {
    int _current = 0;
    //create carousel slider with 3 items and 3 dot indicator
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              //display only the page center
              viewportFraction: 1.0,
              height: 200.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              // enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
                print(_current);
              },
            ),
            items: [
              //print the items from the offers list
              for (var i = 0; i < ofertas.length; i++)
                //create a container with image and offer title, description and button on top of the image
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  OfferDetails( offer: ofertas[i])),
                    );
                  },
                  child:
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: Stack(
                    children: [
                      //image
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Image.network(
                          ofertas[i].urlPost,
                          fit: BoxFit.cover,
                          width: 1000.0,
                        ),
                      ),
                      //title, description and button
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //gold label with "Oferta destacada"
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: goldcolor,
                                ),
                                child: Text(
                                  translation(context).featured_offer_text,
                                  style: TextStyle(
                                    color: greycolor,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                ofertas[i].title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                ofertas[i].subTitle,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              //button
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ) ],
          ),
          //dots indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < ofertas.length; i++)
                Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == i ? goldcolor : Colors.grey,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  //MenuPrincipal parameter user

  Widget MenuPrincipal({required User user}) {
    var menufs = 14;
    var menuiconsize = 40.0;

    TextStyle labelstyle = TextStyle(
      color: Colors.white,
      fontSize: menufs.toDouble(),
      fontWeight: FontWeight.bold,
    );
    return

      GridView.count(
            //no scroll

            physics: NeverScrollableScrollPhysics(),
            //height auto

            shrinkWrap: true,

            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              //1st box
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.replaceRemoveTo(
                        Flurorouter.myWalletRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        color: goldcolor,
                        'assets/icons/menu-cartera.svg',
                        width: menuiconsize,
                        height: menuiconsize,
                      ),
                      SizedBox(height: 20),
                      Text(translation(context).my_wallet_text, style: labelstyle),
                    ],
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.replaceRemoveTo(
                        Flurorouter.transactionsRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        color: goldcolor,
                        'assets/icons/menu-transacciones.svg',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Historial',
                        style: labelstyle,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.replaceRemoveTo(Flurorouter.offersRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        color: goldcolor,
                        'assets/icons/menu-ofertas.svg',
                        width: menuiconsize,
                        height: menuiconsize,
                      ),
                      SizedBox(height: 20),
                      Text(
                        translation(context).offers_text,
                        style: labelstyle,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.replaceRemoveTo(
                        Flurorouter.myAccountRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        color: goldcolor,
                        'assets/icons/micuenta-perfil.svg',
                        width: menuiconsize,
                        height: menuiconsize,
                      ),
                      SizedBox(height: 20),
                      Container(
                          child: Text(
                        translation(context).my_account_text,
                        style: labelstyle,
                      )),
                    ],
                  ),
                ),
              ),

              if (user.type == 'seller' || user.type == 'admin')
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      NavigationService.replaceRemoveTo(
                          Flurorouter.backofficeRoute);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.store_outlined,
                          color: goldcolor,
                          size: menuiconsize,
                        ),
                        SizedBox(height: 20),
                        Container(
                            child: Text(
                          'BackOffice',
                          style: labelstyle,
                        )),
                      ],
                    ),
                  ),
                ),
              //withdraw user
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.replaceRemoveTo(
                        Flurorouter.withdrawSelectRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //withdraw.png
                      Image.asset(
                        'assets/icons/withdraw.png',
                        width: menuiconsize,
                        height: menuiconsize,
                      ),
                      SizedBox(height: 20),
                      Container(
                          child: Text(
                        translation(context).withdraw_text,
                        style: labelstyle,
                      )),
                    ],
                  ),
                ),
              ),
              //admin
              if (user.type == 'admin')
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      NavigationService.replaceRemoveTo(
                          Flurorouter.administracionRoute);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit_note,
                          color: goldcolor,
                          size: menuiconsize,
                        ),
                        SizedBox(height: 20),
                        Container(
                            child: Text(
                          translation(context).administration_text,
                          style: labelstyle,
                        )),
                      ],
                    ),
                  ),
                ),
              /*
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.replaceRemoveTo(
                        Flurorouter.exchangeIndexRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //use FontAwesomeIcons.exchangeAlt
                      Icon(
                        FontAwesomeIcons.buildingColumns,
                        color: goldcolor,
                        size: menuiconsize-5,
                      ),
                      SizedBox(height: 20),
                      Container(
                          child: Text(
                            translation(context).swap_text,
                            style: labelstyle,
                          )),
                    ],
                  ),
                ),
              ),
              //staking
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.replaceRemoveTo(
                        Flurorouter.stakingRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //use FontAwesomeIcons.exchangeAlt
                      Image.asset(
                        'assets/icons/moni.png',
                        width: menuiconsize,
                        height: menuiconsize,
                      ),
                    //icon is image assets/icons/moni.png

                      SizedBox(height: 20),
                      Container(
                          child: Text(
                            'Staking',
                            style: labelstyle,
                          )),
                    ],
                  ),
                ),
              ),
 */
              //box for administraadation
              if (user.type == 'admin')
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      NavigationService.replaceRemoveTo(
                          Flurorouter.conciliationsRoute);

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_money_outlined,
                          color: goldcolor,
                          size: menuiconsize,
                        ),
                        SizedBox(height: 20),
                        Container(
                            child: Text(
                              translation(context).reconciliations_text,
                              style: labelstyle,
                            )),
                      ],
                    ),
                  ),
                ),
            ]);
  }
}
