import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_tour_coin/widgets/button_widget/primary_button.dart';

import '../../../class/language_constants.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';

class CreateInvoicePage extends StatefulWidget {
  const CreateInvoicePage({Key? key}) : super(key: key);

  @override
  State<CreateInvoicePage> createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {
  var montoTTCcontroller = TextEditingController();
  var montocontroller = TextEditingController();
  //descripcion
  var _descriptioncontroller = TextEditingController();
  TextEditingController _addresscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.asset(
            'assets/logo-ttc.png',
            width: 40,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () =>
                NavigationService.replaceRemoveTo(Flurorouter.backofficeRoute),
          )),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: backgroundcolor,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                translation(context).request_payment_text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: goldcolor),
              ),
              //text white "Solicite el pago de su factura directamente a uno de sus clientes"
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                translation(context).request_pay_invoice,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w100, color: white),
              ),

            ),
            Text(translation(context).amount_to_receive_text + ":",style: TextStyle(color: white,fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
            SizedBox(height: 10,),
            TextFormField(
              style: TextStyle(color: white),
              //print initial value with 2 decimals
              controller: montoTTCcontroller,
              onChanged: (value){
                print('el monto es');
                print(value);
                montocontroller.text= value;
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
            //print balance with two decimals, and $ sign before
            SizedBox(height: 20,),
            Text(translation(context).customer_email_text, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            TextField(
              controller: _addresscontroller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '',
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

            SizedBox(height: 20,),
            Text(translation(context).description_text, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            TextField(
              maxLines: 5,
              minLines: 2 ,
              controller: _descriptioncontroller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '',
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
            SizedBox(height: 20,),
            //widget to upload file
            //widget to upload file
            Container(
              child:DottedBorder(
                color: goldcolor,
                dashPattern: const [8, 4],
                strokeWidth: 1, child: Container(
                height: 70,
                width: double.infinity,
                child: Center(
                  child: Text(
                    translation(context).attach_invoice_text,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: goldcolor),
                  ),
                ),
              ),)
            ),
            SizedBox(height: 10,),
            Container(
              alignment: Alignment.center,
              child: Text(
                translation(context).allowed_formats_text + ': PDF, JPG, PNG',
                style: TextStyle(
                    fontSize: 12,
                    color: white),
              ),
            ),
            SizedBox(height: 20,),
            //button to send invoice
            PrimaryButtonWidget(
              text: translation(context).confirm,
              onPressed: () {
                //send invoice
              },
            ),
          ],
        ),
      ),
    );
  }
}
