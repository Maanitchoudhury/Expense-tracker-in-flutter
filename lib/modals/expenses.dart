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
