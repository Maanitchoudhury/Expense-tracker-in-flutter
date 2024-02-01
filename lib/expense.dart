import 'package:expense_tracker/expenselist.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:expense_tracker/widget/chart.dart';
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
        isScrollControlled: false,
        context: context,
        builder: (ctx) => NewExpense(uponAddedExpense: expenseCard));
  }

  void expenseCard(Expensess expenses) {
    setState(() {
      _registeredExpenses.add(expenses);
    });
  }

  void removeExpense(Expensess expenses) {
    final expenseIndex = _registeredExpenses.indexOf(expenses);
    setState(() {
      _registeredExpenses.remove(expenses);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(expenseIndex, expenses);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget initialScreen = const Center(
      child: Text("enter your expense"),
    );

    if (_registeredExpenses.isNotEmpty) {
      initialScreen = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: inputForExpenses,
            icon: const Icon(Icons.add_box_sharp),
          ),
        ],
        title: const Text(" Expense Tracker"),
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: initialScreen),
              ],
            )
          : Row(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: initialScreen),
              ],
            ),
    );
  }
}
