import 'package:khazna/features/transactions/domain/entities/transaction.dart';
import 'package:khazna/features/transactions/domain/repositories/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;
  GetTransactionsUseCase(this.repository);

  Future<List<Transaction>> call() async {
    return await repository.getTransactions();
  }
}