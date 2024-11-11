
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../models/Offer.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';
import 'OfferDetails.dart';
import 'adminOfferDetails.dart';

class AdminOffers extends StatefulWidget {
  const AdminOffers({Key? key}) : super(key: key);

  @override
  State<AdminOffers> createState() => _AdminOffersState();
}

class _AdminOffersState extends State<AdminOffers> {
  bool isloading = true;
  List<Offer> ofertas = [];
  @override
  void initState() {
    //initializeDateFormatting('es_ES');

    HttpApi.httpGet('/admin/posts').then((value) {
      print(value);
print('testino');
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
              NavigationService.replaceRemoveTo(Flurorouter.administracionRoute)

          ,
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        actions: [
          Center(child: Text(translation(context).manage_offers_text2, style: TextStyle(
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
      body: Container(
        color: backgroundcolor,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            //listview
            isloading ? Center(child: CircularProgressIndicator(color: goldcolor,),) : (ofertas.length>0)?ListView.separated(

              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    print('click');


                  },
                  child: Container(
                      color : Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),


                    child: Column( children:[
                    Container(
                    //width will be 30% of the screen

                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(ofertas[index].urlPost),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                      SizedBox(height: 10,),

                      Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //image

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


                                    SizedBox(width: 10,),
                                    //OUTLINE GOLDEN BUTTON, DASHED BORDER
                                    OutlinedButton(
                                      onPressed: () {
                                        //push
                                        final oferta = ofertas[index];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) =>  AdminOfferDetails( offer: oferta)),
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: goldcolor, width: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: Text(translation(context).manage_text, style: TextStyle(color: goldcolor, fontSize: 12),),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )),



                      ],
                    ),])),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 20,);
              },
              itemCount: ((ofertas!=null)?ofertas.length:0),
            ):Center(child: Text(translation(context).no_offers_text, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),)
          ],
        ),
      ),
    );
  }
}
