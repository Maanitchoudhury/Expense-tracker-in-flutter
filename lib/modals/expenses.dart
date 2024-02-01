import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatedDate = DateFormat.yMd();

const uuid = Uuid();

enum Categories { food, travel, leisure, work }

const categoryicons = {
  Categories.food: Icons.dinner_dining,
  Categories.travel: Icons.flight,
  Categories.leisure: Icons.gamepad,
  Categories.work: Icons.laptop_mac
};

class Expensess {
  Expensess(
      {required this.name,
      required this.amount,
      required this.date,
      required this.categories})
      : id = uuid.v4();
  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final Categories categories;
  String get formattedDate {
    return formatedDate.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expensess> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.categories == category)
            .toList();

  final Categories category;
  final List<Expensess> expenses;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
