import 'package:expense_tracker/expenselist.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/modals/expenses.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  final List<Expensess> _registeredExpenses = [
    Expensess(
        name: 'flutter',
        amount: 500,
        date: DateTime.now(),
        categories: Categories.work),
    Expensess(
        name: 'entertainment',
        amount: 10000,
        date: DateTime.now(),
        categories: Categories.leisure),
    Expensess(
        name: 'trips',
        amount: 2000,
        date: DateTime.now(),
        categories: Categories.travel),
    Expensess(
        name: 'restaurents',
        amount: 2000,
        date: DateTime.now(),
        categories: Categories.food)
  ];

  void inputForExpenses() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => NewExpense(uponAddedExpense: expenseCard));
  }

  void expenseCard(Expensess expenses) {
    setState(() {
      _registeredExpenses.add(expenses);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: inputForExpenses,
          icon: const Icon(Icons.add_box_sharp),
        ),
      ], title: const Text(" Expense Tracker")),
      body: Column(
        children: [
          const Text('graph yet to come'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
