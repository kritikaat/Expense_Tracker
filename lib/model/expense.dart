import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category {food , travel , leisure , work}

const categoryIcons = {

  Category.food : Icons.lunch_dining,
  Category.leisure: Icons.movie_creation,
  Category.travel: Icons.flight,
  Category.work: Icons.work,
};

class Expense{
  Expense({required this.name,required this.amount,required this.date,required this.category}) : id = uuid.v4() ;

  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatedDate{
  return formatter.format(date);
}
}


