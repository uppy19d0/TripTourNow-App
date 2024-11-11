import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/models/http/auth_response.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';

class WithdrawWithCrypto extends StatefulWidget {
  //variable to get the preselected option required
  final String? option;

  const WithdrawWithCrypto({super.key, required this.option});

  @override
  State<WithdrawWithCrypto> createState() => _WithdrawWithCryptoState();
}

class _WithdrawWithCryptoState extends State<WithdrawWithCrypto> {
  var montocontroller = TextEditingController(text: '0');
  var montoTTCcontroller = TextEditingController(text: '0');
  String address = '';

  TextEditingController _addresscontroller = TextEditingController();
  List<String> options = ['USDT', 'BTC', 'ETH'];
  double balance = 0.0;
  double conversionrate= 0.0;
  double fee= 0.0;

  bool isloading = true;
  @override
  void initState() {
    //set the preselected option

    HttpApi.httpGet('/user/balance').then((value) {


      setState(() {
        // balance = value['balance'];
        //balance must be double
        balance = value['balance'].toDouble();
        //get value of usdt, btc and eth from coinbase, to usd
        //example     //get https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd
        //get https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=usd
        //get https://api.coingecko.com/api/v3/simple/price?ids=tether&vs_currencies=usd
        if(widget.option=='USDT'){
          HttpApi.httpGet('https://api.coingecko.com/api/v3/simple/price?ids=tether&vs_currencies=usd').then((value) {
            print(value);
            setState(() {
               conversionrate= value['tether']['usd'].toDouble();
            });
          });
        }else if(widget.option=='BTC'){
          HttpApi.httpGet('https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd').then((value) {
            print(value);
            setState(() {
              conversionrate= value['bitcoin']['usd'].toDouble();
            });
          });
        }else if(widget.option=='ETH'){
          HttpApi.httpGet('https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=usd').then((value) {
            print(value);
            setState(() {
             conversionrate= value['ethereum']['usd'].toDouble();
            });
          });
        }
        print('conversionrate');
        print(conversionrate);


      });
      setState(() {
        isloading = false;
      });

    }).catchError((error) {
      print(error);
      print(error.data);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    User user = authProv.user!;
    double percentaje= user.percentaje;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          translation(context).withdrawal_to_crypto_wallets_text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w100),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
          onPressed: () {
            NavigationService.replaceRemoveTo(
                Flurorouter.homeRoute);
          },
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo(
            uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      body: (isloading==false)?
      Container(
        color: backgroundcolor,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Column(
              children: [
                Text(
                  translation(context).available_for_withdraw_text,
                  style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  balance.toStringAsFixed(2) + ' TTC' ,
                  style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            IconWidget(),
            //Disponible ,balance

            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 20,
            ),
            //white paragrahp bold 3 lines, indica el monto que deseas retirar y el monedero el monedero de destino para recibir tus criptomonedas
            Text(
              translation(context).withdrawWithCrypto_enter_amount_text,
              style: TextStyle(
                  color: white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 20,
            ),
        Text(translation(context).you_send_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
        SizedBox(height: 10,),
        //input for monto with bitcoin icon on the right
        TextFormField(
          controller: montocontroller,
          style: TextStyle(color: white),
          onChanged: (value){
            print('el monto es');
            print(value);
            String text='0';
            if(
            value=='' || value=='0'
            ){
              fee=0;
              text='0';
            }else{
              double rate= conversionrate;
              print(rate);
              fee = double.parse(value)/rate*(percentaje/100);
              text = (double.parse(value)-fee).toString();
            }
            //calculate fee
            setState(() {


            });
            montoTTCcontroller.text=text;


          }, inputFormatters: [FilteringTextInputFormatter.digitsOnly],

          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "0.00",
            hintStyle: TextStyle(color: white),
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 10,),
                Image.asset('assets/logo-ttc.png',width: 25,height: 25,),
                SizedBox(width: 10,),
              ],
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(" TTC (Trip Tour Coin)", style: TextStyle(color: white),),
                SizedBox(width: 10,),
              ],
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: white),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: white),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(translation(context).you_receive_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
        SizedBox(height: 10,),
        TextFormField(
          readOnly: true,
          style: TextStyle(color: white),
          //print initial value with 2 decimals
          controller: montoTTCcontroller,

          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: "0.00",
            hintStyle: TextStyle(color: white),
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 10,),
                _buildCryptoIcon(widget.option!),
                SizedBox(width: 10,),
              ],
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.option!, style: TextStyle(color: white),),
                SizedBox(width: 10,),
              ],
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: white),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: white),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
            SizedBox(height:10),
            //TExt
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //fee
                Text(translation(context).comission_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                SizedBox(width: 10,),
                Text(fee.toString()+' '+widget.option!,style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
              ],
            ),
            SizedBox(height: 20,),


            //
            //dropdown with options, background black, white text
            //golden elevated button, text black, text "Retirar", but disabled is the amount is 0 or null or ''

            Text(translation(context).destination_address_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
            //boton de retirar fondos
SizedBox(height: 10,),
            TextField(
              controller: _addresscontroller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                //user ttc icon and TTC texts as suffix,
                //suffixicon, iconbutton
            //suffixicon paste button
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.paste),
                      color: Colors.white,
                      onPressed: () async {
                        ClipboardData? data = await Clipboard.getData('text/plain');
                        if (data != null) {
                          setState(() {
                            _addresscontroller.text = data.text!;
                            ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                                .showSnackBar(
                                SnackBar(
                                  content: Text(
                                      translation(context).text_pasted_text,style: TextStyle(color: Colors.black),
                                      textAlign: TextAlign.center),
                                  backgroundColor: Colors.greenAccent,
                                )
                            );

                          });
                        }else{
                          //show snackbar , no hay texto para copiar
                          ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                              .showSnackBar(
                              SnackBar(
                                content: Text(
                                    translation(context).no_text_to_paste_text,style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center),
                                backgroundColor: Colors.grey[300],
                              )
                          );
                        }
                      },
                    ),

                  ],
                ),
                hintText: translation(context).write_address_text,
                hintStyle: TextStyle(color: Colors.white),

                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            SizedBox(height: 10,),
            //text verifique la direccion de destino,
            Text(translation(context).verify_correct_address_text,style: TextStyle(color: Colors.orangeAccent,fontSize: 14,fontWeight: FontWeight.w100),textAlign: TextAlign.left,),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (montocontroller.text=='' || montocontroller.text==0 )? null :() {

                  //validate the address
                  //if address is empty show snackbar, "La dirección no puede estar vacia"
                  if(_addresscontroller.text==''){
                    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                        .showSnackBar(
                        SnackBar(
                          content: Text(
                              translation(context).address_cant_empty_text,style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center),
                          backgroundColor: Colors.redAccent,
                        )
                    );

                    return;
                  }
                  //check if the amount is zero
                  if(double.parse(montocontroller.text==''?'0':montocontroller.text)==0){
                    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                        .showSnackBar(
                        SnackBar(
                          content: Text(
                              translation(context).amount_greater_zero,style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center),
                          backgroundColor: Colors.redAccent,
                        )
                    );
                    return;
                  }

                  //check if the amount is greater than the balance
                  if(double.parse(montocontroller.text==''?'0':montocontroller.text)>balance){
                    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
                        .showSnackBar(
                        SnackBar(
                          content: Text(
                              translation(context).amount_cant_greater_balance_text,style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center),
                          backgroundColor: Colors.redAccent,
                        )
                    );
                    return;
                  }
                  var data= {
                    'deposit': double.parse(montocontroller.text),
                    'mode': widget.option,
                    'amountCoin': double.parse(montoTTCcontroller.text),
                    'receiver': _addresscontroller.text,
                  };
                  print(data);
                  GlobalTools().showWaitDialog(
                      waitText: translation(context).please_wait);
                  HttpApi.postJson('/coin/withdraw', data).then((value) {
                    //se manda
                    print('se manda');
                    print(value);
                    setState(() {
                      isloading = false;
                    });
                  //close
                    GlobalTools().closeDialog();
                    //show snackbar, "Retiro exitoso"

                    //navigate to home
             //print
                    NavigationService.replaceRemoveTo(Flurorouter.withdrawpaypalconfirmRoute);




                  }).catchError((error) {
                    print(error);
                    print(error.data);
                    setState(() {
                      isloading = false;
                    });
                  });
                },

                child: Text(translation(context).continue_text, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldcolor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  disabledBackgroundColor: Colors.grey[300],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(translation(context).average_time_withdrawal_text,textAlign:TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w100),),




          ],
        ),
      ):Container(color:backgroundcolor,child:Center(child: CircularProgressIndicator(color: goldcolor,)))
      //add floating action button

    );
  }
  Widget _buildCryptoIcon(String crypto) {
    Widget result = Container();
    switch (crypto) {
      case 'USDT':
  result= SvgPicture.asset('assets/icons/coin-usdt.svg',
    height: 30, semanticsLabel: 'Label');
        break;
      case 'ETH':
        result= SvgPicture.asset('assets/icons/coin-eth.svg',
            height: 30, semanticsLabel: 'Label');
        break;
      case 'BTC':
        result= SvgPicture.asset('assets/icons/coin-btc.svg',
            height: 30, semanticsLabel: 'Label');
        break;
      default:
        result= SvgPicture.asset('assets/icons/coin-eth.svg',
            height: 30, semanticsLabel: 'Label');
        break;

    }
    return result;
  }
  Widget IconWidget(){
    //based on widget.option, set the icon, usdt,btc,eth
    //switch (widget.option) {
    switch (widget.option) {
      case 'USDT':
        return SvgPicture.asset('assets/icons/coin-usdt.svg',
            height: 100, semanticsLabel: 'Label');
        break;
      case 'ETH':
        return SvgPicture.asset('assets/icons/coin-eth.svg',
            height: 100, semanticsLabel: 'Label');
        break;
      case 'BTC':
        return SvgPicture.asset('assets/icons/coin-btc.svg',
            height: 100, semanticsLabel: 'Label');
        break;
      default:
        return SvgPicture.asset('assets/icons/coin-eth.svg',
            height: 100, semanticsLabel: 'Label');
        break;
    }

  }
}
