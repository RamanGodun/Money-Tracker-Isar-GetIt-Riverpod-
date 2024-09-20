// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../domain/models/category_model.dart';
// import '../../domain/models/input__state_model.dart';

// class NewExpenseNotifier extends StateNotifier<ExpenseInputData> {
//   NewExpenseNotifier() : super(ExpenseInputData());

//   void updateTitle(String title) {
//     state = state.copyWith(title: title);
//   }

//   void updateAmount(String amount) {
//     state = state.copyWith(amount: amount);
//   }

//   void updateDate(DateTime date) {
//     state = state.copyWith(date: date);
//   }

//   void updateCategory(Category category) {
//     state = state.copyWith(category: category);
//   }

//   bool validateData() {
//     return state.title.isNotEmpty &&
//         state.amount.isNotEmpty &&
//         double.tryParse(state.amount) != null &&
//         state.date != null;
//   }
// }
