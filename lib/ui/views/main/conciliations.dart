import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trip_tour_coin/api/HttpApi.dart';

import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';
//import reconciliation model
import 'package:trip_tour_coin/models/reconciliation.dart';

import 'detailsConciliation.dart';

class ConciliationsView extends StatefulWidget {
  const ConciliationsView({super.key});

  @override
  State<ConciliationsView> createState() => _ConciliationsViewState();
}

class _ConciliationsViewState extends State<ConciliationsView> {
  bool isloading = true;
  //list of reconciliation
  List<Reconciliation> reconciliations = [];
  //initstate
  @override
  void initState() {
    super.initState();
    //initstate
    //HttpApi getConciliations

    HttpApi.httpGet('/reconciliations').then((value) {
      print(value);


      //convert value to json
      var data = value['reconciliations'];
      print("aca");
      print(data);
      //create a list of reconciliations
      //loop through datA
      setState(() {
        for (var i = 0; i < data.length; i++) {
          print(data[i]);
          //create a reconciliation
          Reconciliation reconciliation = Reconciliation.fromJson(data[i]);
          print(reconciliation);
          print(reconciliation.name);
          //add reconciliation to reconciliations

          reconciliations.add(reconciliation);
          //
        }
        isloading = false;

      });
    }).catchError((error) {
      print(error);
    });

  }
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    //initstate


    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).reconciliation_list_text),
        backgroundColor: Colors.black,
        //icon to go back home
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            NavigationService.replaceRemoveTo(Flurorouter.homeRoute);
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
      //body stepper
      body: Container(
        color: backgroundcolor,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child:(isloading?Center(child: CircularProgressIndicator(color: goldcolor,)):
        ListView.builder(
          itemCount: reconciliations.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                //backgroundcolor: Colors.black,
                leading:           FaIcon(
                  FontAwesomeIcons.fileImport,
                  //outline
                  color: goldcolor,
                  size: 35,
                ),
                tileColor: Colors.black,
                title: Text(reconciliations[index].name, style: TextStyle(color: Colors.white),),
                subtitle: Text("RD\$" +reconciliations[index].amount + " ", style: TextStyle(color: goldcolor),),
               //trailing is status is pending, color grey, if status is approved, color green
                trailing: Column(
                  //aling to right
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StatusLabel(reconciliations[index].status),
                  //create at date format
                    Text(reconciliations[index].bank, style: TextStyle(color: Colors.white),),
                    Text(reconciliations[index].created_at.toString().substring(0,10), style: TextStyle(color: Colors.white),),
                  ],
                ),
                onTap: () {
                  //navigate to detail
                  //push to detail using navigator.push
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailConciliation(id: reconciliations[index].id,)));
                },
              ),
            );
          },
        )
      )))
    ;
  }
 Text StatusLabel(String status) {
    if (status == "pending") {
      return Text( translation(context).pending_text, style: TextStyle(color: Colors.grey));
    } else {
  //aprobado green , rejected red
      return Text(status == "approved" ? translation(context).approved_text : translation(context).declined_text,
          style: TextStyle(color: status == "approved" ? Colors.green : Colors.red));
    }
  }
}
