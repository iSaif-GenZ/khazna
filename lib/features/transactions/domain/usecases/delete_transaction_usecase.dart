import 'package:khazna/features/transactions/domain/repositories/transaction_repository.dart';

class DeleteTransactionUseCase {
  final TransactionRepository repository;
  DeleteTransactionUseCase(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteTransaction(id);
  }
}