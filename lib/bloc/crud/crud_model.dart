import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final String amount;
  final bool isIncome;
  final DateTime timestamp;

  TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isIncome,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory TransactionModel.fromMap(Map<String, dynamic> map, String id) {
    return TransactionModel(
      id: id,
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      amount: map['amount'] ?? '0',
      isIncome: map['isIncome'] ?? false,
      timestamp: map['timestamp'] != null 
          ? (map['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'amount': amount,
      'isIncome': isIncome,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}