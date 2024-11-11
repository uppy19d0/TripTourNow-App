import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/theme.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/Offer.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import 'EditOffer.dart';

class BackofficeOffers extends StatefulWidget {
  const BackofficeOffers({Key? key}) : super(key: key);

  @override
  State<BackofficeOffers> createState() => _BackofficeOffersState();
}

class _BackofficeOffersState extends State<BackofficeOffers> {
  bool isloading = true;
  List<Offer> ofertas = [];
  @override
  void initState() {
    //initializeDateFormatting('es_ES');

    HttpApi.httpGet('/user/posts').then((value) {


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
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () =>
          NavigationService.replaceRemoveTo(Flurorouter.backofficeRoute)

        ,
        ),

        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        actions: [
          Center(child: Text(translation(context).my_offers_text, style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold
          ),)),
          SizedBox(width: 15),
        ],
      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo(
            uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
      floatingActionButton: FloatingActionButton(
      backgroundColor: goldcolor,
        onPressed: () {
          NavigationService.replaceTo(Flurorouter.newofferRoute);
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        color: backgroundcolor,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        child: ListView(
          children: [
            //listview
            isloading ? Center(child: CircularProgressIndicator(color: goldcolor,),) : ListView.separated(

              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    print('click');


                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),

                    decoration: BoxDecoration(

                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //image
                        Container(
                          //width will be 30% of the screen
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(ofertas[index].urlPost),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ofertas[index].title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text(ofertas[index].description, style: TextStyle(color: Colors.white, fontSize: 14),),
                            SizedBox(height: 10,),

                            Row(
                              //edit and delete
                              children: [
                                Row(
                                  children  : [
                                    Image.asset('assets/logo-ttc.png',width: 25,height: 25,),
                                    SizedBox(width: 10,),
                                    Text(ofertas[index].price.toString(), style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold),),
                                    SizedBox(width: 10,),
                                  ],
                                ),
                                Spacer(),

                                //edit and delete buttons
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                          //store current offer in provider
                                        final oferta = ofertas[index];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  EditOffer( offer: oferta)),
                                        );

                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Icon(Icons.edit, color: goldcolor,),
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: (){
                                        //confirm delete
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                             //the background is black the textbuttons goldencolor and the normal text white
                                              return AlertDialog(
                                                backgroundColor: Colors.black,
                                                title: Text(translation(context).delete_offer_text, style: TextStyle(color: Colors.white),),
                                                content: Text(translation(context).confirm_delete_offer_text, style: TextStyle(color: Colors.white),),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text(translation(context).cancel_text, style: TextStyle(color: goldcolor),),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      //delete offer
                                                      HttpApi.delete('/post/delete/${ofertas[index].id}').then((value) {
                                                        print(value);
                                                        setState(() {
                                                          ofertas.removeAt(index);
                                                        });
                                                      }).catchError((error) {
                                                        print(error);
                                                        print(error.data);
                                                      });
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text(translation(context).delete_text, style: TextStyle(color: goldcolor),),
                                                  ),
                                                ],
                                              );
                                            });

                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Icon(Icons.delete, color: goldcolor,),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )),



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
      ),
    );
  }
}
