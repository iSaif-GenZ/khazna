import 'package:khazna/features/transactions/domain/entities/transaction.dart';
import 'package:khazna/features/transactions/domain/repositories/transaction_repository.dart';

class AddTransactionUseCase {
  final TransactionRepository repository;
  AddTransactionUseCase(this.repository);

  Future<void> call(Transaction transaction) async {
    return await repository.addTransaction(transaction);
  }
}