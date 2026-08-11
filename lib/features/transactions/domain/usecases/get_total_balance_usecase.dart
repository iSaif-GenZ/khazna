import 'package:khazna/features/transactions/domain/entities/transaction.dart';

class GetTotalBalanceUseCase {
  double call(List<Transaction> transactions) {
    return transactions.fold(0.0, (sum, item) => sum + item.price);
  }
}
