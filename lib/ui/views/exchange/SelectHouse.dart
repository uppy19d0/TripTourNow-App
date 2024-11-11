import 'package:flutter/material.dart';
import 'package:trip_tour_coin/models/CasaDeCambio.dart';

import '../../../class/language_constants.dart';
import '../../../api/HttpApi.dart';
import '../../../theme.dart';
typedef _callback = void Function(CasaDeCambio casa);

class SelectHouse extends StatefulWidget {
  final _callback callback;
  const SelectHouse({Key? key, required this.callback}) : super(key: key);



  @override
  State<SelectHouse> createState() => _SelectHouseState();
}

class _SelectHouseState extends State<SelectHouse> {
  bool isloading = true;
  List<CasaDeCambio> casas = [];
  @override
  void initState() {
    //initializeDateFormatting('es_ES');

    HttpApi.httpGet('/casa_de_cambios').then((value) {

      //convert value to json
      var data=   value['data'];
      for (var i = 0; i < data.length; i++) {
        print(data[i]);
        CasaDeCambio casa = CasaDeCambio.fromJson(data[i]);
        casas.add(casa);//
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
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).select_currency_text,),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: backgroundcolor,
        child: ListView.builder(
        //padding: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

        itemCount: casas.length,
        itemBuilder: (context, index) {
          return
              Container(
                child: GestureDetector(
                  onTap: (){
                    widget.callback(casas[index]);

                  },
                  child: Card(
                    color: Colors.black,
                    child: ListTile(

                     //image for the leading
                      leading: Image.network('http://3.16.217.214/'+casas[index].image),
                      title: Text(casas[index].name, style: TextStyle(color: goldcolor)),
                      subtitle: Text(casas[index].address, style: TextStyle(color: Colors.white),)
                    ),
                  ),
                )
              );
        },
      ),)
    );

  }
}
