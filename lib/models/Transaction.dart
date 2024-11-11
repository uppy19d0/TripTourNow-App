// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

Transaction transactionFromJson(String str) => Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
    required this.amount,
    required this.receiver,
    required this.sender,
    //add created_at, status and type
    required this.createdAt,
    required this.status,
    required this.type,
    //add offerId as int
    required this.offerId,

  });

  double amount;
  String receiver;
  String sender;
  //add created_at, status and type
  DateTime createdAt;
  String status;
  String type;
  //add offerId as int
  int offerId;





  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(

    //amount: json["amount"],
    //type 'int' is not a subtype of type 'double'
    amount: json["amount"].toDouble(),
    receiver: json["receiver"],
    sender: json["sender"],
    //add created_at, status and type
    //add created_at as datetime
    createdAt: DateTime.parse(json["created_at"]),
    status: json["status"],
    type: json["type"],
    //IF OFFERID IS NOT NULL THEN ADD IT
    offerId: json["offerId"] == null ?0: json["offerId"],



  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "receiver": receiver,
    "sender": sender,
    //add created_at, status and type
    "created_at": createdAt.toIso8601String(),
    "status": status,
    "type": type,
    //IF OFFERID IS NOT NULL THEN ADD IT
    "offerId": offerId == null ? null : offerId,
  };
}