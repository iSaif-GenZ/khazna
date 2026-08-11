import 'package:khazna/features/transactions/data/datasources/transaction_local_datasource.dart';
import 'package:khazna/features/transactions/data/models/transaction_model.dart';
import 'package:khazna/features/transactions/domain/entities/transaction.dart';
import 'package:khazna/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository{
  final TransactionLocalDatasource localDatasource;
  TransactionRepositoryImpl(this.localDatasource);

  @override  
  Future<List<Transaction>> getTransactions() async {
    final models = await localDatasource.getTransactions();
    return models.map((model) => model.toEntity()).toList();
  }

  @override  
  Future<void> addTransaction(Transaction transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    await localDatasource.addTransaction(model);
  }

  @override  
  Future<void> deleteTransaction(int id) async {
    await localDatasource.deleteTransaction(id);
  }
}