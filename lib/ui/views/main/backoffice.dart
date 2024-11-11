import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trip_tour_coin/ui/layouts/core_layaout.dart';
import 'package:trip_tour_coin/widgets/button_widget/primary_button.dart';

import '../../../class/language_constants.dart';
import '../../../router/router.dart';
import '../../../services/navigation_service.dart';
import '../../../theme.dart';

class Backoffice extends StatefulWidget {
  const Backoffice({Key? key}) : super(key: key);

  @override
  State<Backoffice> createState() => _BackofficeState();
}

class _BackofficeState extends State<Backoffice> {
  @override
  Widget build(BuildContext context) {
    return CoreLayout(child: Container(
        color: backgroundcolor,
        height: double.infinity,
        child:Menu(),

    ));
  }
  Widget Menu() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
        child:
        Column(
        children:
            [
              Container(child:
        GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,

            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: [
              //1st box
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {

                    NavigationService.replaceRemoveTo(
                        Flurorouter.backofficeListOffersRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        color: goldcolor,
                        'assets/icons/menu-ofertas.svg',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        translation(context).my_offers_text,

                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {

                    NavigationService.replaceRemoveTo(
                        Flurorouter.historyRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        color: goldcolor,
                        'assets/icons/receive.svg',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        translation(context).my_sales_text,

                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {

                    NavigationService.replaceRemoveTo(
                        Flurorouter.withdrawsRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     // withdraw.png
                      Image.asset(
                        'assets/icons/withdraw.png',
                        width: 50,
                        height: 50,
                      ),

                      SizedBox(height: 20),
                      Text(
                        translation(context).withdrawals_text,

                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {

                    NavigationService.replaceRemoveTo(
                        Flurorouter.invoicesRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        color: goldcolor,
                        'assets/icons/remittance.svg',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(height: 20),
                      Text(
                        translation(context).bills_text,

                      ),
                    ],
                  ),
                ),
              ),

            ])),
            SizedBox(height: 20),
            PrimaryButtonWidget(text: translation(context).new_bill_text, onPressed: (){
              NavigationService.replaceRemoveTo(Flurorouter.createinvoiceRoute);
            })

            ]));
  }
}

