
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/models/Offer.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../shared/global_dialog.dart';
import '../../../theme.dart';

class OfferDetails extends StatefulWidget {
  final Offer offer;
  const OfferDetails({Key? key, required this.offer }) : super(key: key);

  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  late Offer oferta;
  DateFormat dateFormat = DateFormat("E, yyyy-MM-dd ");

  //inititalize number controller to number 1
  TextEditingController _numbercontroller = TextEditingController(text: '1');
  double total = 0.0 ;
  double balance=0.0;
  bool isloading = false;


  //get the offer from the offer argument
  @override
  void initState() {

    //set isloading to true
    setState(() {

      oferta = widget.offer;
      total = oferta.price;
      isloading = true;
    });



    //await for get offers
    HttpApi.httpGet('/user/balance').then((value) {


    setState(() {
      balance = value['balance'].toDouble();
      isloading = false;
    });


    }).catchError((error) {
      print(error);
      print(error.data);

    });



  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(


        title: Text(translation(context).offer_details_text),
        backgroundColor: Colors.black,

      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo( uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      body:Container(
        height: double.infinity,
        width: double.infinity,
        color:backgroundcolor,
        child :ListView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          children: [
            Container(
              child:     Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage( oferta.urlPost),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
            //title bold and subtitle normal
            SizedBox(height: 10,),
            Text(oferta.title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text(oferta.description, style: TextStyle(color: Colors.white, fontSize: 14),),
            //number input with + and - buttons
            SizedBox(height: 10,),
            Row(
              children: [
                Container(

                  height: 50,
                  //width auto to fit the content
                  width: MediaQuery.of(context).size.width * 0.35,

                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,

                    textAlign: TextAlign.center,
                    controller: _numbercontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      //TEXT WHITE



                      prefixIcon: IconButton(
                        icon: Icon(Icons.remove, color: Colors.white,),
                        onPressed: (){
                          setState(() {
                            if(int.parse(_numbercontroller.text) > 1){

                              _numbercontroller.text = (int.parse(_numbercontroller.text) - 1).toString();
                              //update total
                              total = oferta.price * int.parse(_numbercontroller.text);
                            }
                          });
                        },
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add, color: Colors.white,),
                        onPressed: (){
                          setState(() {
                            _numbercontroller.text = (int.parse(_numbercontroller.text) + 1).toString();
                            total = oferta.price * int.parse(_numbercontroller.text);

                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color:goldcolor, width: 1),
                      ),
                      hintText: '1',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),

            ), SizedBox(width: 10,),
                //golden button Comprar
                Container(
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (balance >= total)? (){
                        setState(() {
                          isloading = true;
                        });
                        GlobalTools().showWaitDialog(
                            waitText: translation(context).please_wait);
                        print('comprar oferta');
                        var data = {'id': oferta.id, 'quantity': _numbercontroller.text};
                        print(data);
                        HttpApi.postJson('/post/buy', data).then((value) {
                          setState(() {
                            isloading = false;
                          });
                          //close the wait dialog
                          //redirect to buysuccess
                          Navigator.of(context).pop();
                          //fluro router navigate to buysuccess
                          NavigationService.replaceRemoveTo(
                              Flurorouter.buysuccessRoute);

                        }).catchError((error) {
                          print(error);
                          print(error.data);
                          setState(() {
                            isloading = false;
                          });
                        });
                      }:null,
                      child: Text(translation(context).buy_offer_text, style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),),
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: Colors.grey, backgroundColor: goldcolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                )


              ],
            ),

            SizedBox(height: 10,),
            Row(
              children: [
                Text('Total: ', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
//TTC ICON PNG
                Image.asset('assets/logo-ttc.png', height: 20, width: 20,),
                SizedBox(width: 10,),
                //total with only 2 decimals
                Text(total.toStringAsFixed(2), style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Text('TTC', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 5,),
            (balance >= total)? Text(''):Text(translation(context).insufficient_balance_text, style: TextStyle(color: Colors.red, fontSize: 14),),
            SizedBox(height: 10,),
            //row spacebetween gold text both sides
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(oferta.bought.toString() + " " + translation(context).purchased_text + ' ', style: TextStyle(color: goldcolor, fontSize: 12, ),),
                //print la oferta vence en format dateFormat.format(oferta.endDate)
                Text(translation(context).offer_expires_text + ': '+ dateFormat.format(oferta.expireDate), style: TextStyle(color: goldcolor, fontSize: 12, ),),


              ],
            ),
            SizedBox(height: 20,),
            //label white Descripcion de la oferta
            Text(translation(context).offer_description_text, style: TextStyle(color: goldcolor, fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            //description text
            Text(oferta.description, style: TextStyle(color: Colors.white, fontSize: 14),),
            SizedBox(height: 20,),
            //ubicacion y  contactos gold
            Text(translation(context).location_n_contacts_text, style: TextStyle(color: goldcolor, fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            //tel . +1 800 000 0000
            Text('Tel. ' + oferta.phone, style: TextStyle(color: Colors.white, fontSize: 14),),
            SizedBox(height: 5,),
            //address
            Text(oferta.address, style: TextStyle(color: Colors.white, fontSize: 14),),

          ],
        )
      ),
    );
  }
}
