//    //{name: casa de cambio 1, phone: bdjej, address: fhfj, usd: true, eur: false, gbp: false, dop: false, cad: false, chf: false, image: {}, googlemaplink: aasd}

import 'dart:convert';
//replicate this class

//fromjson and tojson

CasaDeCambio casaDeCambioFromJson(String str) => CasaDeCambio.fromJson(json.decode(str));

String casaDeCambioToJson(CasaDeCambio data) => json.encode(data.toJson());

class CasaDeCambio {
  CasaDeCambio({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.usd,
    required this.eur,
    required this.gbp,
    required this.dop,
    required this.cad,
    required this.chf,
    required this.image,
    required this.googlemaplink,
  });

  String name;
  String phone;
  String address;
  bool usd;
  bool eur;
  bool gbp;
  bool dop;
  bool cad;
  bool chf;
  String image;
  String googlemaplink;
  int id;

  factory CasaDeCambio.fromJson(Map<String, dynamic> json) => CasaDeCambio(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    //convert to bool
    usd: (json["usd"]==1) ? true : false,
    eur: (json["eur"]==1) ? true : false,
    gbp: (json["gbp"]==1) ? true : false,
    dop: (json["dop"]==1) ? true : false,
    cad: (json["cad"]==1) ? true : false,
    chf: (json["chf"]==1) ? true : false,
    image: json["image"],
    googlemaplink: json["googlemaplink"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "address": address,
    "usd": usd,
    "eur": eur,
    "gbp": gbp,
    "dop": dop,
    "cad": cad,
    "chf": chf,
    "image": image,
    "googlemaplink": googlemaplink,
  };

}
