// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  AuthResponse({
    required this.token,
    required this.auth,
  });

  String token;
  User auth;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        token: json["token"],
        auth: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "auth": auth.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastname,
    required this.fullname,
    required this.phone,
    required this.birthday,
    required this.email,
    required this.twofa,
    required this.country,
    required this.email_verified,
    required this.entropy_created,
    required this.address,
    required this.verificationStatus,
    required this.dni,
    required this.type,
    required this.id_back,
    required this.id_front,
    required this.selfie,
    required this.percentaje,


  });

  int id;
  String firstName;
  String lastname;
  String fullname;
  String phone;
  DateTime birthday;
  String email;
  bool twofa;
  String country;
  bool email_verified;
  bool entropy_created;
  String address;
  String verificationStatus;
  String dni;
  String type;
  //id_front, id_back, selfie
  String id_front;
  String id_back;
  String selfie;
  double percentaje;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      dni: json["dni"],
      firstName: json["firstName"],
      lastname: json["lastName"],
      fullname: json["firstName"] + ' '+json["lastName"],
      phone: json["phone"],
      birthday: DateTime.parse(json["birthday"]),
      email: json["email"],
      country: json['country'],
      twofa: json['is_2FA_activated'],
      email_verified: json['email_verified'],
      entropy_created: json['entropy_created'],
      address: json['address'],
      //percentaje, if 0 or null then 0, parse to double, comes 5
      percentaje: json['percentaje'] == null ? 0.0 : double.parse(json['percentaje'].toString()),
//

      verificationStatus: json["verification_status"]==null ? 'unverified': json["verification_status"],
      type: json['type'],
      //sefie
      selfie: json['selfie'] == null ? '': 'http://3.16.217.214'+json['selfie'],
      id_back: json['id_back'] == null ? '':  'http://3.16.217.214'+json['id_back'],
      id_front: json['id_front'] == null ? '': 'http://3.16.217.214'+json['id_front'],
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dni": dni,
        "name": firstName,
        "lastname": lastname,
        "fullname": fullname,
        "phone": phone,
        "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "email": email,
        'entropy_created': entropy_created,
        'country': country,
        'is_2FA_activated': twofa,
        'email_verified': email_verified,
        'address': address,
        'verification_status': verificationStatus,
        'type': type,
        'selfie': selfie,
        'id_back': id_back,
        'id_front': id_front,
        'percentaje': percentaje,

      };
}

class Data {
  Data({
    required this.home,
    required this.notifications,
  });

  Home home;
  Notifications notifications;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        home: Home.fromJson(json["home"]),
        notifications: Notifications.fromJson(json["notifications"]),
      );

  Map<String, dynamic> toJson() => {
        "home": home.toJson(),
        "notifications": notifications.toJson(),
      };
}

class Home {
  Home({
    required this.time,
    required this.myBills,
    required this.goToProperty,
    required this.activities,
    required this.myCondos,
    required this.condos,
    required this.locations,
  });

  DateTime time;
  int myBills;
  int goToProperty;
  int activities;
  List<MyCondo> myCondos;
  List<Condo> condos;
  List<LocationElement> locations;

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        time: DateTime.parse(json["time"]),
        myBills: json["my_bills"],
        goToProperty: json["go_to_property"],
        activities: json["activities"],
        myCondos: List<MyCondo>.from(
            json["my_condos"].map((x) => MyCondo.fromJson(x))),
        condos: List<Condo>.from(json["condos"].map((x) => Condo.fromJson(x))),
        locations: List<LocationElement>.from(
            json["locations"].map((x) => LocationElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "time": time.toIso8601String(),
        "my_bills": myBills,
        "go_to_property": goToProperty,
        "activities": activities,
        "my_condos": List<dynamic>.from(myCondos.map((x) => x.toJson())),
        "condos": List<dynamic>.from(condos.map((x) => x.toJson())),
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
      };
}

class Condo {
  Condo({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Condo.fromJson(Map<String, dynamic> json) => Condo(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class LocationElement {
  LocationElement({
    required this.id,
    required this.name,
    required this.apiUrl,
  });

  int id;
  String name;
  String apiUrl;

  factory LocationElement.fromJson(Map<String, dynamic> json) =>
      LocationElement(
        id: json["id"],
        name: json["name"],
        apiUrl: json["api_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "api_url": apiUrl,
      };
}

class MyCondo {
  MyCondo({
    required this.id,
    required this.condoUserId,
    required this.name,
    required this.unit,
    required this.map,
    required this.location,
    required this.areas,
    required this.documents,
    required this.staffs,
    required this.tickets,
    required this.activities,
    required this.goToProperty,
    required this.notifications,
  });

  int id;
  int condoUserId;
  String name;
  String unit;
  String map;
  MyCondoLocation location;
  List<dynamic> areas;
  List<dynamic> documents;
  List<dynamic> staffs;
  Tickets tickets;
  Activities activities;
  GoToProperty goToProperty;
  Notifications notifications;

  factory MyCondo.fromJson(Map<String, dynamic> json) => MyCondo(
        id: json["id"],
        condoUserId: json["condo_user_id"],
        name: json["name"],
        unit: json["unit"],
        map: json["map"],
        location: MyCondoLocation.fromJson(json["location"]),
        areas: List<dynamic>.from(json["areas"].map((x) => x)),
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
        staffs: List<dynamic>.from(json["staffs"].map((x) => x)),
        tickets: Tickets.fromJson(json["tickets"]),
        activities: Activities.fromJson(json["activities"]),
        goToProperty: GoToProperty.fromJson(json["go_to_property"]),
        notifications: Notifications.fromJson(json["notifications"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "condo_user_id": condoUserId,
        "name": name,
        "unit": unit,
        "map": map,
        "location": location.toJson(),
        "areas": List<dynamic>.from(areas.map((x) => x)),
        "documents": List<dynamic>.from(documents.map((x) => x)),
        "staffs": List<dynamic>.from(staffs.map((x) => x)),
        "tickets": tickets.toJson(),
        "activities": activities.toJson(),
        "go_to_property": goToProperty.toJson(),
        "notifications": notifications.toJson(),
      };

  bool isEqual(MyCondo model) {
    return id == model.id;
  }
}

class Activities {
  Activities({
    required this.items,
    required this.counts,
  });

  List<Item> items;
  Counts counts;

  factory Activities.fromJson(Map<String, dynamic> json) => Activities(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        counts: Counts.fromJson(json["counts"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "counts": counts.toJson(),
      };
}

class Counts {
  Counts({
    required this.pending,
    required this.confirmed,
    required this.cancelled,
  });

  int pending;
  int confirmed;
  int cancelled;

  factory Counts.fromJson(Map<String, dynamic> json) => Counts(
        pending: json["pending"],
        confirmed: json["confirmed"],
        cancelled: json["cancelled"],
      );

  Map<String, dynamic> toJson() => {
        "pending": pending,
        "confirmed": confirmed,
        "cancelled": cancelled,
      };
}

class Item {
  Item({
    required this.id,
    required this.startAt,
    required this.endAt,
    required this.startAtFormat,
    required this.endAtFormat,
    required this.message,
    required this.comments,
    required this.status,
    required this.statusName,
    required this.name,
    required this.phone,
    required this.email,
    required this.file,
    required this.adults,
    required this.kids,
  });

  int id;
  DateTime startAt;
  DateTime endAt;
  String startAtFormat;
  String endAtFormat;
  String message;
  dynamic comments;
  String status;
  String statusName;
  String name;
  String phone;
  String email;
  dynamic file;
  int adults;
  int kids;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        startAt: DateTime.parse(json["start_at"]),
        endAt: DateTime.parse(json["end_at"]),
        startAtFormat: json["start_at_format"],
        endAtFormat: json["end_at_format"],
        message: json["message"],
        comments: json["comments"],
        status: json["status"],
        statusName: json["status_name"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        file: json["file"],
        adults: json["adults"],
        kids: json["kids"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_at": startAt.toIso8601String(),
        "end_at": endAt.toIso8601String(),
        "start_at_format": startAtFormat,
        "end_at_format": endAtFormat,
        "message": message,
        "comments": comments,
        "status": status,
        "status_name": statusName,
        "name": name,
        "phone": phone,
        "email": email,
        "file": file,
        "adults": adults,
        "kids": kids,
      };
}

class GoToProperty {
  GoToProperty({
    required this.principal,
    required this.guest,
  });

  Activities principal;
  Activities guest;

  factory GoToProperty.fromJson(Map<String, dynamic> json) => GoToProperty(
        principal: Activities.fromJson(json["principal"]),
        guest: Activities.fromJson(json["guest"]),
      );

  Map<String, dynamic> toJson() => {
        "principal": principal.toJson(),
        "guest": guest.toJson(),
      };
}

class MyCondoLocation {
  MyCondoLocation({
    required this.name,
    required this.weather,
  });

  String name;
  Weather weather;

  factory MyCondoLocation.fromJson(Map<String, dynamic> json) =>
      MyCondoLocation(
        name: json["name"],
        weather: Weather.fromJson(json["weather"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "weather": weather.toJson(),
      };
}

class Weather {
  Weather({
    required this.conditionCode,
    required this.temperature,
  });

  int conditionCode;
  String temperature;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        conditionCode: json["condition_code"],
        temperature: json["temperature"],
      );

  Map<String, dynamic> toJson() => {
        "condition_code": conditionCode,
        "temperature": temperature,
      };
}

class Notifications {
  Notifications({
    required this.unread,
    required this.data,
  });

  int unread;
  List<NotificationsDatum> data;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        unread: json["unread"],
        data: List<NotificationsDatum>.from(
            json["data"].map((x) => NotificationsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "unread": unread,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class NotificationsDatum {
  NotificationsDatum({
    required this.id,
    required this.date,
    required this.type,
    required this.status,
    required this.title,
    required this.body,
  });

  int id;
  DateTime date;
  String type;
  String status;
  String title;
  String body;

  factory NotificationsDatum.fromJson(Map<String, dynamic> json) =>
      NotificationsDatum(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        type: json["type"],
        status: json["status"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "type": type,
        "status": status,
        "title": title,
        "body": body,
      };
}

class Tickets {
  Tickets({
    required this.created,
    required this.categories,
    required this.data,
  });

  int created;
  List<String> categories;
  List<TicketsDatum> data;

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
        created: json["created"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        data: List<TicketsDatum>.from(
            json["data"].map((x) => TicketsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "created": created,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TicketsDatum {
  TicketsDatum({
    required this.id,
    required this.code,
    required this.condoUserId,
    required this.adminName,
    required this.date,
    required this.category,
    required this.status,
    required this.messages,
  });

  int id;
  String code;
  int condoUserId;
  String adminName;
  DateTime date;
  String category;
  Status status;
  List<Message> messages;

  factory TicketsDatum.fromJson(Map<String, dynamic> json) => TicketsDatum(
        id: json["id"],
        code: json["code"],
        condoUserId: json["condo_user_id"],
        adminName: json["admin_name"],
        date: DateTime.parse(json["date"]),
        category: json["category"],
        status: Status.fromJson(json["status"]),
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "condo_user_id": condoUserId,
        "admin_name": adminName,
        "date": date.toIso8601String(),
        "category": category,
        "status": status.toJson(),
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    required this.id,
    required this.date,
    required this.ticketId,
    required this.userId,
    required this.adminId,
    required this.type,
    required this.adminName,
    required this.message,
    required this.file,
    required this.status,
  });

  int id;
  DateTime date;
  int ticketId;
  dynamic userId;
  dynamic adminId;
  String type;
  String adminName;
  String message;
  String file;
  String status;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        ticketId: json["ticket_id"],
        userId: json["user_id"],
        adminId: json["admin_id"],
        type: json["type"],
        adminName: json["admin_name"],
        message: json["message"],
        file: json["file"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "ticket_id": ticketId,
        "user_id": userId,
        "admin_id": adminId,
        "type": type,
        "admin_name": adminName,
        "message": message,
        "file": file,
        "status": status,
      };
}

class Status {
  Status({
    required this.name,
    required this.color,
    required this.title,
  });

  String name;
  String color;
  String title;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        name: json["name"],
        color: json["color"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "color": color,
        "title": title,
      };
}
