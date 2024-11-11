import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import 'package:trip_tour_coin/utils/Functions.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/Offer.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';
import '../../layouts/core_layaout.dart';
import 'OfferDetails.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  bool isloading = true;
  List<Offer> ofertas = [];
  @override
  void initState() {
    //initializeDateFormatting('es_ES');

    HttpApi.httpGet('/posts').then((value) {

      //convert value to json
      var data=   value['data'];
      for (var i = 0; i < data.length; i++) {
        print(data[i]);
        Offer offer = Offer.fromJson(data[i]);
        ofertas.add(offer);//
      }
      setState(() {
        isloading = false;
      });
    }).catchError((error) {
      print(error);
      print(error.data);
    });
  }
  @override
  Widget build(BuildContext context) {
    return CoreLayout(child:
      Container(
        color: backgroundcolor,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translation(context).my_offers_text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
            Divider(color: Colors.white),
            SizedBox(height: 10),
            //listview
            if(ofertas.length == 0)
              Center(child: Text(translation(context).no_offers_to_show_text, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),),)
            else
            isloading ? Center(child: CircularProgressIndicator(color: goldcolor,),) : ListView.separated(

              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    //push to
                    final oferta = ofertas[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  OfferDetails( offer: oferta)),
                    );

                  },
                  child: Container(

                  decoration: BoxDecoration(

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //image
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(ofertas[index].urlPost),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(ofertas[index].title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text(ofertas[index].description, style: TextStyle(color: Colors.white, fontSize: 12),),
                      SizedBox(height: 10,),
                      Row(
                        children  : [
                          Image.asset('assets/logo-ttc.png',width: 25,height: 25,),
                          SizedBox(width: 10,),
                          Text(ofertas[index].price.toString(), style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold),),
                          SizedBox(width: 10,),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //generate random numer
                          Text(ofertas[index].bought.toString() + " " + translation(context).purchased_text + ' ', style: TextStyle(color: goldcolor, fontSize: 10),),
                          Text(translation(context).offer_expires_in_text + ': '+ DateFormat('MM/dd, hh:mm a','es').format(ofertas[index].expireDate) , style: TextStyle(color: goldcolor, fontSize: 10),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(color: Colors.white,),
                    ],
                  ),),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 20,);
              },
              itemCount: ofertas.length,
            )
          ],
        ),
      ),);
  }
}
