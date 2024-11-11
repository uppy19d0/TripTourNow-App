//model reconciliation with id: 2, name: joshua, amount: 12345, TTCAmount: 218.05, bank: BANCO BHD LEON, reference: 1235456, status: pending, created_at: 2023-08-18T00:35:44.000000Z, updated_at: 2023-08-18T00:35:44.000000Z
import 'package:flutter/material.dart';

import 'dart:convert';

class Reconciliation{
    int id;
    String name;
    String amount;
    String TTCAmount;
    String bank;
    String reference;
    String status;
    DateTime created_at;



    Reconciliation({
        required this.id,
        required this.name,
        required this.amount,
        required this.TTCAmount,
        required this.bank,
        required this.reference,
        required this.status,
        required this.created_at,

    });

    //create fromJson method
    factory Reconciliation.fromJson(Map<String, dynamic> json) => Reconciliation(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        TTCAmount: json["TTCAmount"],
        bank: json["bank"],
        reference: json["reference"],
        status: json["status"],
        created_at: DateTime.parse(json["created_at"]),
    );



}