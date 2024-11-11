import 'dart:convert';


class Withdraw {
  Withdraw({
    required this.id,
    required this.amount,
    required this.mode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user_email,
    required this.user_name,
    required this.user_address,
    //receiver
    required this.receiver,
  });

  int id;
  double amount;
  String mode;
  String status;
  String user_name;
  String user_email;
  String user_address;
  DateTime createdAt;
  DateTime updatedAt;
  String receiver;

  factory Withdraw.fromJson(Map<String, dynamic> json) => Withdraw(
    id: json["id"],
   // amount: json["amountCoin"],
    //type 'int' is not a subtype of type 'double'
    amount: json["amountCoin"].toDouble(),
    user_name: json["user"]["firstName"] + " " + json["user"]["lastName"],
    user_email: json["user"]['email'],
    user_address: json["user"]["entropy"],

    mode: json["mode"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    //receiver, check if null

    receiver: json["receiver"] == null ? '': json["receiver"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "address": user_address,
    "mode": mode,

    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "receiver": receiver,

  };
}