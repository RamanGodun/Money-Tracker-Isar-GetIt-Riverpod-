import 'package:flutter/material.dart';
import '../../domain/models/expenses_model.dart';
import '../components/chart/chart_alt.dart';
import '../components/chart/chart.dart';
import '../components/expenses_list/expenses_list.dart';
import '1.new_expense.dart';

class ExpensesMainScreen extends StatefulWidget {
  const ExpensesMainScreen({super.key});

  @override
  State<ExpensesMainScreen> createState() {
    return _ExpensesMainScreenState();
  }
}

class _ExpensesMainScreenState extends State<ExpensesMainScreen> {
  //
  final List<ExpenseModel> _registeredExpenses = [];
  bool showAltChart = false;

  @override
  Widget build(BuildContext context) {
    // local vars
    final widthMQ = MediaQuery.of(context).size.width;

    Widget? registeredExpensesList = (_registeredExpenses.isNotEmpty)
        ? ExpensesList(
            expenses: _registeredExpenses, onRemoveExpense: _removeExpense)
        : const Center(
            child: Text('Список витрат поки що пустий'),
          );

    Widget addExpenseButton = IconButton(
      color: Colors.amber,
      onPressed: _openAddExpenseOverlay,
      icon: const Icon(Icons.add, size: 45),
    );

//
    return Scaffold(
      appBar: AppBar(
        title: const Text('Трекер витрат'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: SafeArea(
        child: widthMQ < 600
            ? Column(
                children: [
                  widthMQ < 600
                      ? Expanded(
                          child: SizedBox(
                              child: showAltChart
                                  ? ChartAlt(_registeredExpenses)
                                  : Chart(expenses: _registeredExpenses)),
                        )
                      : Expanded(
                          child: SizedBox(
                              child: !showAltChart
                                  ? ChartAlt(_registeredExpenses)
                                  : Chart(expenses: _registeredExpenses))),
                  Expanded(
                    child: registeredExpensesList,
                  ),
                ],
              )
            : Row(
                children: [
                  widthMQ < 600
                      ? Expanded(
                          child: SizedBox(
                              child: showAltChart
                                  ? ChartAlt(_registeredExpenses)
                                  : Chart(expenses: _registeredExpenses)),
                        )
                      : Expanded(
                          child: SizedBox(
                              child: !showAltChart
                                  ? ChartAlt(_registeredExpenses)
                                  : Chart(expenses: _registeredExpenses))),
                  Expanded(
                    child: registeredExpensesList,
                  ),
                ],
              ),
      ),

      //
      floatingActionButton: widthMQ < 600 ? addExpenseButton : null,
    );
  }

  // METHODS next
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
      // ctx - is context for showModalBottomSheet
    );
  }

  void _addExpense(ExpenseModel expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(ExpenseModel expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Витрату видалено'),
        action: SnackBarAction(
          label: 'Відмінити',
          onPressed: () {
            setState(() => _registeredExpenses.insert(expenseIndex, expense));
          },
        ),
      ),
    );
  }
  //
}
