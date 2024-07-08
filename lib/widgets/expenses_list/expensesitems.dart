import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class Expensesitems extends StatelessWidget{
  const Expensesitems(this.expenses,{super.key});

  final Expense expenses;

  @override
  Widget build(context){
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expenses.name, style: Theme.of(context).textTheme.titleLarge,),
            const SizedBox(height: 4,),
            Row(
              children: [
                Text('Rs. ${expenses.amount.toStringAsFixed(2)}',),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expenses.category],),
                  const SizedBox(width: 8,),
                  Text(expenses.formatedDate),
                ],
              )
              ],
            )
          ],
        )
      ),
    );
  }
}
