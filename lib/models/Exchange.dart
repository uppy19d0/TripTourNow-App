import 'dart:convert';

import 'CasaDeCambio.dart';

//replicate this class
//    'user_id' => $user->id,
//             'amount' => $amount,
//             'currency' => $currency,
//             'status' => 'pending',
//             'house_id' => $casa_de_cambio,
class Exchange {
  Exchange({
    required this.id,
    required this.user_id,
    required this.amount,
    required this.currency,
    required this.status,
    required this.house,
  });

  int id;
  int user_id;
  double amount;
  String currency;
  String status;
  CasaDeCambio house = CasaDeCambio(
      id: 0,
      name: '',
      phone: '',
      address: '',
      usd: false,
      eur: false,
      gbp: false,
      dop: false,
      cad: false,
      chf: false,
      image: '',
      googlemaplink: '');

  factory Exchange.fromJson(Map<String, dynamic> json) => Exchange(
        id: json["id"],
        user_id: json["user_id"],
        //int to double amount
        amount: json["amount"].toDouble(),


        currency: json["currency"],
        status: json["status"],


        house: CasaDeCambio.fromJson(json["house"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "amount": amount,
        "currency": currency,
        "status": status,
      };
}