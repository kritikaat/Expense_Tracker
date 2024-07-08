import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/user_expense.dart';
import 'package:expense_tracker/widgets/chart.dart'; // Import the chart widget
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expense> _registerExpense = [
    Expense(
      name: 'Flutter Course',
      amount: 500.00,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      name: 'Pizza',
      amount: 600,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void addExpenese(Expense expense) {
    setState(() {
      _registerExpense.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    var registerindex = _registerExpense.indexOf(expense);
    setState(() {
      _registerExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registerExpense.insert(registerindex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => UserExpense(
        onAddExpense: addExpenese,
      ),
    );
  }

  @override
  Widget build(context) {
    var ispotrit = MediaQuery.of(context).orientation == Orientation.portrait;
    
  
    Widget mainContent = const Center(
      child: Text('No expenses found, start adding some!'),
    );

    if (_registerExpense.isNotEmpty) {
      mainContent = ExpensesList(
        registrelist: _registerExpense,
        removeitem: removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ispotrit? Column(
        children: [
          Expanded(
              child: ExpenseChart(expenses: _registerExpense), // Display the chart
          ),          
          const SizedBox(height: 20),
          Expanded(
            child: mainContent,
          ),
        ],
      ):Row(
        children: [
          Expanded(
            //flex: 2,
            child: ExpenseChart(expenses: _registerExpense), // Display the chart
          ),
          const SizedBox(height: 20),
          Expanded(
            //flex: 3,
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
