class TransactionModel {
  final DateTime date;
  final String type;
  final double amount;
  final String note;

  TransactionModel({
    required this.date,
    required this.type,
    required this.amount,
    this.note = '',
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'type': type,
        'amount': amount,
        'note': note,
      };

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        date: DateTime.parse(json['date']),
        type: json['type'],
        amount: json['amount'],
        note: json['note'],
      );
}
