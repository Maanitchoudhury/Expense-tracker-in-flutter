import 'package:expense_tracker/modals/expenses.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatedDate = DateFormat.yMd();
Categories selectedCategory = Categories.food;

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.uponAddedExpense});

  final void Function(Expensess expenses) uponAddedExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final expenseController = TextEditingController();
  final amountController = TextEditingController();
  @override
  void dispose() {
    expenseController.dispose();
    amountController.dispose();
    super.dispose();
  }

  DateTime? _pickedDate;

  void datePicker() async {
    final now = DateTime.now();
    final pastDate = DateTime(now.year - 1, now.month, now.day);
    final futureDate = DateTime(now.year + 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: pastDate,
        lastDate: futureDate);

    setState(() {
      _pickedDate = pickedDate;
    });
  }

  void submittedData() {
    final enteredAmount = double.tryParse(amountController.text);
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;

    if (expenseController.text.trim().isEmpty ||
        invalidAmount ||
        _pickedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("invalid entry"),
          content: const Text("please enter valid data😐"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("ok"))
          ],
        ),
      );
      return;
    }
    widget.uponAddedExpense(Expensess(
        name: expenseController.text,
        amount: enteredAmount,
        date: _pickedDate!,
        categories: selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Expanded(
        child: Column(
          children: [
            TextField(
              //text entering
              controller: expenseController,
              maxLength: 20,
              decoration: const InputDecoration(
                label: Text("Enter expense"),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Row(children: [
              Expanded(
                child: TextField(
                  //amount entering
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Enter the amount"),
                  ),
                ),
              ),
            ]),
            const SizedBox(width: 17),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton(
                      value: selectedCategory,
                      items: Categories.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          selectedCategory = value;
                        });
                      }),
                  const Spacer(),
                  Text(_pickedDate == null
                      ? 'No date selected'
                      : formatedDate.format(_pickedDate!)),
                  IconButton(
                    onPressed: datePicker,
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      debugPrint(expenseController.text);
                      debugPrint(amountController.text);
                      submittedData();
                      Navigator.pop(context);
                    },
                    child: const Text("save"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("cancel"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
