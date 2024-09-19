// class ExpensesNotifier extends StateNotifier<ExpensesState> {
//   final IsarService _isarService;
//   final FirebaseService _firebaseService;
//   final Connectivity _connectivity;

//   ExpensesNotifier(
//     this._isarService,
//     this._firebaseService,
//     this._connectivity,
//   ) : super(ExpensesState(expenses: [])) {
//     // Викликаємо метод для перевірки з'єднання і синхронізації
//     _initializeExpenses();
//   }

//   Future<void> _initializeExpenses() async {
//     // Завантажуємо дані з локальної бази при старті
//     await loadExpensesFromLocal();
//     // Перевіряємо наявність інтернету і, якщо він є, синхронізуємо
//     await _syncWithFirebase();
//   }

//   Future<void> loadExpensesFromLocal() async {
//     try {
//       state = state.copyWith(isLoading: true);
//       final localExpenses = await _isarService.getAllExpenses();
//       state = state.copyWith(expenses: localExpenses, isLoading: false);
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }

//   Future<void> _syncWithFirebase() async {
//     // Перевіряємо наявність підключення до інтернету
//     final connectivityResult = await _connectivity.checkConnectivity();
//     if (connectivityResult != ConnectivityResult.none) {
//       try {
//         final remoteExpenses =
//             await _firebaseService.getAllExpensesFromFirebase();
//         // Оновлюємо дані в локальній базі на основі даних з Firebase
//         for (final expense in remoteExpenses) {
//           await _isarService.addExpense(expense);
//         }
//         // Повторно завантажуємо оновлені витрати з локальної бази
//         await loadExpensesFromLocal();
//       } catch (e) {
//         state = state.copyWith(error: "Error syncing with Firebase: $e");
//       }
//     }
//   }

//   Future<void> addExpense(ExpenseModel expense) async {
//     try {
//       // Спочатку додаємо витрату в локальну базу
//       await _isarService.addExpense(expense);
//       // Синхронізуємо з Firebase, якщо є інтернет
//       await _syncWithFirebase();
//       loadExpensesFromLocal(); // Оновлюємо локальні дані
//     } catch (e) {
//       state = state.copyWith(error: e.toString());
//     }
//   }

//   Future<void> removeExpense(ExpenseModel expense) async {
//     try {
//       // Спочатку видаляємо витрату з локальної бази
//       await _isarService.removeExpense(expense);
//       // Синхронізуємо з Firebase, якщо є інтернет
//       await _syncWithFirebase();
//       loadExpensesFromLocal(); // Оновлюємо локальні дані
//     } catch (e) {
//       state = state.copyWith(error: e.toString());
//     }
//   }
// }
