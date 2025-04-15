class TransactionModel {
  final int id;
  final String title;
  final String dateTime;
  final String account;
  final double amount;
  final String status;

  TransactionModel({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.account,
    required this.amount,
    required this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      dateTime: json['dateTime'],
      account: json['account'],
      amount: json['amount'],
      status: json['status'],
    );
  }
}
