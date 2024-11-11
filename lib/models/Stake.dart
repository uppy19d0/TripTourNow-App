//create a model for stake with
// 1. stake id
// 2. percentage
// 3. end_date (date when the stake ends)
// 4. amount
// 5. status
// 6. stake_type
// 7. stake_date (date when the stake was created)

// Path: lib\models\Stake.dart
class Stake {
  Stake({
    required this.id,
    required this.percentage,
    required this.endDate,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.duration,
  });

  int id;
  double percentage;
  DateTime endDate;
  double amount;
  String status;
  DateTime createdAt;
  int duration;

  factory Stake.fromJson(Map<String, dynamic> json) => Stake(
    id: json["id"],
    percentage: json["percentaje"].toDouble(),
    endDate: DateTime.parse(json["end_date"]),
    amount: json["amount"].toDouble(),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "percentage": percentage,
    "end_date": endDate.toIso8601String(),
    "amount": amount,
    "status": status,
    "created_at": createdAt.toIso8601String(),
  };
}