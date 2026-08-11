import 'package:isar_community/isar.dart';
import 'package:khazna/features/transactions/data/models/transaction_model.dart';

abstract class TransactionLocalDatasource {
  Future<List<TransactionModel>> getTransactions();
  Future<void> addTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(int id);
}

class TransactionLocalDatasourceImpl implements TransactionLocalDatasource {
  final Isar isar;
  TransactionLocalDatasourceImpl(this.isar);

  @override  
  Future<List<TransactionModel>> getTransactions() async {
    return await isar.transactionModels.where().findAll();
  }

  @override  
  Future<void> addTransaction(TransactionModel Transaction) async {
    await isar.writeTxn(() async {
      await isar.transactionModels.put(Transaction);
    });
  }

  @override  
  Future<void> deleteTransaction(int id) async {
    await isar.writeTxn(() async {
      await isar.transactionModels.delete(id);
    });
  }
}