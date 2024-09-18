// import 'package:intl/intl.dart';
// import 'package:uuid/uuid.dart';

// import 'category_model.dart';

// final formatter = DateFormat.yMd();
// const uuid = Uuid();

// class ExpenseModel {
//   ExpenseModel({
//     required this.title,
//     required this.amount,
//     required this.date,
//     required this.category,
//   }) : id = uuid.v4();

//   final String id;
//   final String title;
//   final double amount;
//   final DateTime date;
//   final Category category;

//   String get formattedDate {
//     return formatter.format(date);
//   }
// }

// class ExpenseBucket {
//   const ExpenseBucket({
//     required this.category,
//     required this.expenses,
//     this.categorySum = const [0.0, 0.0, 0.0, 0.0],
//   });

//   ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
//       : expenses = allExpenses
//             .where((expense) => expense.category == category)
//             .toList(),
//         categorySum = List<double>.generate(4, (index) {
//           final filteredExpenses = allExpenses
//               .where((expense) => expense.category == Category.values[index])
//               .toList();
//           return filteredExpenses.fold<double>(
//               0, (acc, expense) => acc + expense.amount);
//         });

//   final Category category;
//   final List<ExpenseModel> expenses;
//   final List<double> categorySum;

//   double get totalExpenses {
//     double sum = 0;
//     for (final expense in expenses) {
//       sum += expense.amount;
//     }
//     return sum;
//   }
// }
