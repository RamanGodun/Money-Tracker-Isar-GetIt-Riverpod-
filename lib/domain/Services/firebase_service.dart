// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/expense_model.dart';

// class FirebaseService {
//   final CollectionReference _expensesCollection =
//       FirebaseFirestore.instance.collection('expenses');

//   Future<void> addExpenseToFirebase(ExpenseModel expense) async {
//     await _expensesCollection.add(expense.toMap());
//   }

//   Future<List<ExpenseModel>> getAllExpensesFromFirebase() async {
//     final snapshot = await _expensesCollection.get();
//     return snapshot.docs.map((doc) {
//       return ExpenseModel.fromMap(doc.data() as Map<String, dynamic>);
//     }).toList();
//   }

//   Future<void> removeExpenseFromFirebase(String expenseId) async {
//     await _expensesCollection.doc(expenseId).delete();
//   }
// }
