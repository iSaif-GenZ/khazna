import 'package:khazna/features/transactions/domain/entities/transaction.dart';

class GetTotalExpensesUsecase {
  double call(List<Transaction> transactions) {
    return transactions
        .where((item) => item.price < 0)
        .fold(0.0, (sum, item) => sum + item.price);
  }
}
