import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expensesitems.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.registrelist, required this.removeitem});

  final List<Expense> registrelist;
  final Function(Expense expense) removeitem;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: registrelist.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(registrelist[index]),
        background: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.85),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                12), // Match the border radius of the card
          ),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
        onDismissed: (direction) {
          removeitem(registrelist[index]);
        },
        child: Expensesitems(registrelist[index]),
      ),
    );
  }
}
