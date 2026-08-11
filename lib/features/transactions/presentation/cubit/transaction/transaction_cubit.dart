import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazna/features/transactions/domain/entities/transaction.dart';
import 'package:khazna/features/transactions/domain/usecases/add_transaction_usecase.dart';
import 'package:khazna/features/transactions/domain/usecases/delete_transaction_usecase.dart';
import 'package:khazna/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction/transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactionsUseCase getTransactionsUseCase;
  final AddTransactionUseCase addTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;

  TransactionCubit({
    required this.getTransactionsUseCase,
    required this.addTransactionUseCase,
    required this.deleteTransactionUseCase,
  }) : super(TransactionInitial());

  Future<void> getTransactions() async {
    emit(TransactionLoading());
    try {
      final transactions = await getTransactionsUseCase();
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    try {
      emit(TransactionLoading());
      await addTransactionUseCase(transaction);
      final transactions = await getTransactionsUseCase();
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> deleteTransaction(int id) async {
    try {
      await deleteTransactionUseCase(id);
      await getTransactionsUseCase();
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}
