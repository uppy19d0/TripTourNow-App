import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../api/HttpApi.dart';
import '../../../class/language_constants.dart';
import '../../../providers/ui_provider.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../shared/BottomNavigation.dart';
import '../../../theme.dart';

class BuyWithBank extends StatefulWidget {
  const BuyWithBank({super.key});

  @override
  State<BuyWithBank> createState() => _BuyWithBankState();
}

class _BuyWithBankState extends State<BuyWithBank> {
  int _index = 0;
  var montocontroller = TextEditingController();
  var montoTTCcontroller = TextEditingController();
  //nombre controller
  //banco controller
  //cuenta controller
  //referencia
  var nombrecontroller = TextEditingController();
  var bancocontroller = TextEditingController();
  var cuentacontroller = TextEditingController();
  var referenciacontroller = TextEditingController();
  //tipo de cuenta

  //set bancos as a list of strings : BANCO BDI, BANCO DE LEON
  //set tipo de cuenta as a list of strings : AHORRO, CORRIENTE
  //set selectedBanco as a string
  //set selectedTipoCuenta as a string
  var bancos = ['BANCO BDI', 'BANCO BHD LEON', 'BANCO LOPEZ DE HARO'];
  var tipoCuenta = ['AHORRO', 'CORRIENTE'];
  var selectedBanco = '';
  var selectedTipoCuenta = '';
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    var tasa = 0.017662881;

    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).reconcile_purchase_text, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100),),
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: MyBottomNavigation(onTap: (int idx) {
        if (idx == uiProvider.selectedMainMenu) return;
        uiProvider.selectedMainMenu = idx;
        uiProvider.appBarReset();
        NavigationService.navigateTo(uiProvider.pages[uiProvider.selectedMainMenu]);
      }),
   //body stepper
body:
Container(
  color: backgroundcolor  ,
  height: MediaQuery.of(context).size.height,
  padding: EdgeInsets.all(10),

    child:
Stepper(

  currentStep: _index,
  onStepCancel: () {
    if (_index > 0) {
      setState(() {
        _index -= 1;
      });
    }
  },
  onStepContinue: () {
    if (_index <= 0) {
      setState(() {
        _index += 1;
      });
    }
  },
  onStepTapped: (int index) {
    setState(() {
      _index = index;
    });
  },
  //remove controls
  controlsBuilder: (context, controller) {
    return const SizedBox.shrink();
  },

        steps: [
          Step(
            title: Text(translation(context).select_amount_text),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text( translation(context).amount_text +":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  SizedBox(height: 10,),
                  //input for monto with bitcoin icon on the right
                  TextFormField(
                    controller: montocontroller,
                    style: TextStyle(color: white),
                    onChanged: (value){
                      print('el monto es');
                      print(value);
                      var value2 = double.parse(value);
                      var value3 = value2 * tasa;
                      var value4 = value3.toStringAsFixed(2);
                      montoTTCcontroller.text= value4;

                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "0.00",
                      hintStyle: TextStyle(color: white),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('DOP', style: TextStyle(color: white),),
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

                  SizedBox(height: 40,),
                  Text(translation(context).amount_to_receive_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  SizedBox(height: 10,),
                  TextFormField(
                    style: TextStyle(color: white),
                    //print initial value with 2 decimals
                    controller: montoTTCcontroller,
                    onChanged: (value){
                      if(value.isEmpty){
                        montocontroller.text = '0';
                        value= '0';
                      }
                      print('el monto es');
                      print(value);
                      var value2 = double.parse(value);
                      var value3 = value2 / tasa;
                      var value4 = value3.toStringAsFixed(2);
                      montocontroller.text= value4;

                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(" TTC (Trip Tour Coin)", style: TextStyle(color: white),),
                          SizedBox(width: 10,),
                        ],
                      ),
                      hintStyle: TextStyle(color: white),
                      //use assets/logo-ttc.png as prefix icon
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 10,),
                          Image.asset('assets/logo-ttc.png',width: 25,height: 25,),
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
                  //label for "Nombre"
                  //input for "Nombre"
                ],
              )
            ),
          ),
          Step(
            title: Text(translation(context).make_your_payment_text),
            content: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Text(translation(context).make_bank_transfer_text, style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  //label for "Monto"
                  SizedBox(height: 20,),
                  Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(

                      //subtitle is 2 lines with name and cuenta
                      subtitle: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/logobhdleon.png',height: 80,),
                          Text('Cuenta: 11486130021'),
                          Text('Carlos Silverio'),
                          // Swift: BCBHDOSDXXX
                          Text('Swift: BCBHDOSDXXX',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      trailing: Text('Ahorro', style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                      isThreeLine: true,
                    ),
                  ),
                ],
              )
            ),
          ),
          Step(
            title:  Text(translation(context).verify_payment_text),
            content: Container(

                child: Column(
                  //alignment: Alignment.centerLeft,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Text(translation(context).account_holder_name_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                    SizedBox(height: 10,),
                    TextFormField(
                      //borders white
                      style: TextStyle(color: white),
                      controller: nombrecontroller,
                      decoration: InputDecoration(

                        hintStyle: TextStyle(color: white),
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
                    SizedBox(height: 30,),
                    Text(translation(context).bank_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                    //referencia

                    SizedBox(height: 10,),
                    //dropdown for "Banco" with selectedBanco as value and bancos as items, background must be black
                    DropdownButtonFormField(
                      dropdownColor: Colors.black,
                      style: TextStyle(color: white),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      onChanged: (newValue) {
                        setState(() {
                          selectedBanco = newValue.toString();
                        });
                      },
                      items: bancos.map((banco) {
                        return DropdownMenuItem(
                          child: new Text(banco),
                          value: banco,
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 30,),
                    Text(translation(context).reference_number_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                    SizedBox(height: 10,),
                    TextFormField(
                      //borders white
                      style: TextStyle(color: white),
                      controller: referenciacontroller,
                      decoration: InputDecoration(

                        hintStyle: TextStyle(color: white),
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
                    SizedBox(height: 30,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        //color gold
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: goldcolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                          ),
                          onPressed: () => {
                            handlesubmit()

                          },
                          child: Text(translation(context).buy_text)),

                    ),
                    SizedBox(height: 40,),
                    Text(translation(context).it_take_time_text ,style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.w100),textAlign: TextAlign.center,),
                  ],
                )
            ),
          ),

        ],
)
)

    );
  }
  //handlesubmit
  void handlesubmit(){


    //check if monto is empty
    if(montocontroller.text.isEmpty){
     //show snackbar with error message
      print('monto is empty');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(translation(context).amount_cant_empty),
          backgroundColor: Colors.red,
        ),
      );
      return;

    }
    //check if name is empty
    if(nombrecontroller.text.isEmpty){
      //show snackbar with error message
      print('nombre is empty');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(translation(context).name_cant_be_empty),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    //check if banco is empty
    if(selectedBanco.isEmpty){
      //show snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(translation(context).bank_cant_be_empty),
          backgroundColor: Colors.red,
        ),
      );
      return;

    }
    //validar que la referencia sea de al menos 4 caracteres
    if(referenciacontroller.text.length < 4){
      //show snackbar with error message
      print('referencia is empty');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(translation(context).reference_must_be_text),
          backgroundColor: Colors.red,
        ),
      );
      return;

    }

    var nData = {
      'name': nombrecontroller.text,
      'amount': montocontroller.text,
      'TTCAmount': montoTTCcontroller.text,
      'bank': selectedBanco,
      'reference': referenciacontroller.text,
      'status': 'pending'
    };
    debugPrint(nData.toString());
    HttpApi.postJson('/reconciliation', nData).then((value) {
      print(value);
      if(value['status'] == 'success'){
        //print success 50 times
        NavigationService.replaceRemoveTo(
            Flurorouter.reconciliationConfirmRoute);

      }
      //navigate to success page
      //if error
      //show error message
    }).catchError((error) {
      print(error);
    });
  }

}
