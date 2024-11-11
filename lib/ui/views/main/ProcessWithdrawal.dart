import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/Withdraw.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';
import 'package:intl/intl.dart';

//import moment

class ProcessWithdrawal extends StatefulWidget {
  final  Withdraw retiro;
  const ProcessWithdrawal({Key? key, required this.retiro}) : super(key: key);

  @override
  State<ProcessWithdrawal> createState() => _ProcessWithdrawalState();
}

class _ProcessWithdrawalState extends State<ProcessWithdrawal> {
  //texteditingcontroller for the paypal transaction id
  TextEditingController paypalTransactionId = TextEditingController();
  //createdAt = widget.retiro.createdAt; datetime
  late DateTime createdAt= DateTime.now();
  bool isdisabled = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(translation(context).withdrawal_details_text, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
           onPressed: () =>
                NavigationService.replaceRemoveTo(Flurorouter.withdrawsRoute),
        ),
      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo( uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      body: Container(
        color: backgroundcolor,
        height: double.infinity,
        width: double.infinity,
        child: ListView(

          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          children: [
            IconWidget(widget.retiro.mode),
            SizedBox(height: 20,),
            //text white: "Detalles del retiro"
            Column(
              children: [
                Text(
                  translation(context).amount_to_send_text,
                  style: TextStyle(
                      color: white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.retiro.amount.toStringAsFixed(2) + ' '+ widget.retiro.mode ,
                  style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20,),
            //hora de la solicitud
            Row(
              children: [
                Text(translation(context).request_date_text + ': ', style: TextStyle(color: Colors.white),),
        //format date using moment MMMM d, yyyy

                //Text(DateFormat('MMMM d, yyyy').format(widget.retiro.createdAt), style: TextStyle(color: Colors.white),),
                //print the date YYYY-MM-DD HH:MM:SS
                Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.retiro.createdAt), style: TextStyle(color: Colors.white),),

              ],
            ),
            SizedBox(height: 20,),
            //status del retiro
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translation(context).withdrawal_status_text + ': ', style: TextStyle(color: Colors.white),),
                Text( (widget.retiro.status == '0') ? translation(context).pending_text : translation(context).approved_text,
                  style: TextStyle(color: (widget.retiro.status== '0')? Colors.amberAccent: Colors.green),),
              ],
           ),
            //nombre del usuario
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translation(context).username_text + ': ', style: TextStyle(color: Colors.white),),
                Text(widget.retiro.user_name, style: TextStyle(color: Colors.white),),
              ],
            ),
            //correo del receptor
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translation(context).email_text + ': ', style: TextStyle(color: Colors.white),),
                Row(
                  children: [
                    Text(widget.retiro.user_email, style: TextStyle(color: Colors.white,fontSize: 12),),
                    SizedBox(width: 10,),
                    //iconbutton
                    IconButton(
                      icon: Icon(Icons.copy, color: Colors.white,),
                      onPressed: () {
                        //copy the email to the clipboard
                        Clipboard.setData(ClipboardData(text: widget.retiro.user_email));
                        //show a snackbar
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(translation(context).email_copied_text),
                          duration: Duration(seconds: 2),
                        ));
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Container(child:Text(translation(context).payment_address_text, style: TextStyle(color: Colors.white),)),
            //text with adress and copy button
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.retiro.receiver, style: TextStyle(color: Colors.white),),
                IconButton(
                  icon: Icon(Icons.copy, color: Colors.white,),
                  onPressed: () {
                    //copy the address to the clipboard
                    Clipboard.setData(ClipboardData(text: widget.retiro.receiver));
                    //show a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(translation(context).copied_address_text),
                      duration: Duration(seconds: 2),
                    ));
                  },
                ),
              ],
            ),
            (widget.retiro.status == '0')? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(height: 20,),

              //text white: "Debe Indicar el id de la transaccion de paypal para poder continuar"
              //input for the paypal transaction id
              SizedBox(height: 20,),
              Text(translation(context).payment_reference_text,textAlign: TextAlign.start, style: TextStyle(color: Colors.white),),



              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: paypalTransactionId,
                keyboardType: TextInputType.text,
                onChanged: (value){
                  //disable button if the value is empty or null
                  setState(() {
                    isdisabled = (value == '')? true : false;
                  });

                },
                decoration: InputDecoration(


                  //text color white
                  labelStyle: TextStyle(color: Colors.white),

                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),

                ),
              ),

              SizedBox(height: 20,),
              Container(
                width:double.infinity,
              //golden button to process the withdrawal
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  //backgrund gray if disabled
                  backgroundColor: (isdisabled)? Colors.grey : goldcolor,

                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),


                ),
                onPressed: (isdisabled)? null :() {
                  //checj if the value is empty
                  if(paypalTransactionId.text == ''){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(translation(context).must_enter_pay_reference_text),
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }
                  GlobalTools().showWaitDialog(
                      waitText: translation(context).please_wait);
                  Provider.of<UiProvider>(context, listen: false)
                      .selectedMainMenu = 0; // Reinicia el menu
                  String reference = paypalTransactionId.text;
                  var nData = {
                    'reference': reference,
                    'id': widget.retiro.id,
                  };
                  print(nData);

                  HttpApi.postJson('/admin/process_paypal_withdraw', nData).then((value) {
                    print(value);
                    if(value['status'] == 'success'){
                      GlobalTools().closeDialog();
                      //Navigator.pushNamed(context, '/success');
                      NavigationService.replaceRemoveTo(
                          Flurorouter.confirmationRoute);
                    }
                    //navigate to success page
                    //if error
                    //show error message
                  }).catchError((error) {
                    print(error);
                    GlobalTools().closeDialog();

                  });
                  print('se manda');
                },
                child: Text(translation(context).process_withdrawal_text, style: TextStyle(color: (isdisabled)? Colors.white : Colors.black),
              ),)
            ),

                  SizedBox(height: 10,),
                  Container(
                    width:double.infinity,
                alignment: Alignment.center,
                child:

                  Text(translation(context).must_enter_pay_reference_text, style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,),
                  ),
                      ]):Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[SizedBox(height:20),Text(translation(context).withdrawal_already_processed_text, style: TextStyle(color: goldcolor,fontSize: 16),textAlign: TextAlign.center,)
              ],)
    ,),
          ],
        ),
      ),
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
  Widget IconWidget(option){
    //based on widget.option, set the icon, usdt,btc,eth
    //switch (widget.option) {
    switch (option) {
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
