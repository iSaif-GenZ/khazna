import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazna/features/transactions/domain/entities/transaction.dart';
import 'package:khazna/features/transactions/domain/usecases/get_total_balance_usecase.dart';
import 'package:khazna/features/transactions/domain/usecases/get_total_expenses_usecase.dart';
import 'package:khazna/features/transactions/domain/usecases/get_total_income_usecase.dart';
import 'package:khazna/features/transactions/presentation/cubit/transaction_summary/transaction_summary_state.dart';

class TransactionSummaryCubit extends Cubit<TransactionSummaryState> {
  final GetTotalBalanceUseCase getTotalBalanceUseCase;
  final GetTotalIncomeUseCase getTotalIncomeUseCase;
  final GetTotalExpensesUsecase getTotalExpensesUsecase;

  TransactionSummaryCubit({
    required this.getTotalBalanceUseCase,
    required this.getTotalIncomeUseCase,
    required this.getTotalExpensesUsecase,
  }) : super(TransactionSummaryInitial());

  void calculateSummary(List<Transaction> transactions) {
    final balance = getTotalBalanceUseCase(transactions);
    final income = getTotalIncomeUseCase(transactions);
    final expenses = getTotalExpensesUsecase(transactions);

    emit(TransactionSummaryCalculated(totalBalance: balance, totalIncome: income, totalExpenses: expenses));
  }
}