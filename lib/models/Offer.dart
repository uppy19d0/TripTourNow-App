// To parse this JSON data, do
//
//     final offer = offerFromJson(jsonString);

import 'dart:convert';

Offer offerFromJson(String str) => Offer.fromJson(json.decode(str));

String offerToJson(Offer data) => json.encode(data.toJson());

class Offer {
  Offer({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.phone,
    required this.address,
    required this.expireDate,
    required this.price,
    required this.urlPost,
    required this.bought,
    required this.status,
    required this.percentaje
  });

  String title;
  String subTitle;
  String description;
  String phone;
  String address;
  DateTime expireDate;
  double price;
  String urlPost;
  int bought;
  String status;
  int id;
  double percentaje;
  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    title: json["title"],
    subTitle: json["subTitle"],
    description: json["description"],
    phone: (json["phone"]==null) ? "" : json["phone"],
    address: (json["address"]==null) ? "" : json["address"],
    expireDate: DateTime.parse(json["expire_date"]),
    //add price and fix "type 'int' is not a subtype of type 'double'"
    price:json["price"].toDouble(),
    urlPost: 'https://triptournow.com/public/images/'+json["urlPost"],
    bought: json["bought"],
    status: json["status"],
    percentaje: json["percentaje"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subTitle": subTitle,
    "description": description,
    "phone": (phone==null) ? "" : phone,
    "address": (address==null) ? "" : address,
    "expire_date": expireDate.toIso8601String(),
    "price": price,
    "urlPost": urlPost,
    "bought" : bought,
    "status" : status,
    "percentaje" : percentaje,
    'id': id,
  };
}
