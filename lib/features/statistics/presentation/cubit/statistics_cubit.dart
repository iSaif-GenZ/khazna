import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazna/features/statistics/domain/cubit/statistics_state.dart';
import 'package:khazna/features/statistics/domain/usecases/get_category_breakdown_usecase.dart';
import 'package:khazna/features/statistics/domain/usecases/get_income_expense_trend_usecase.dart';
import 'package:khazna/features/transactions/domain/entities/transaction.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final GetCategoryBreakdownUseCase getCategoryBreakdownUseCase;
  final GetIncomeExpenseTrendUseCase getIncomeExpenseTrendUseCase;

  StatisticsCubit({
    required this.getCategoryBreakdownUseCase,
    required this.getIncomeExpenseTrendUseCase,
  }) : super(StatisticsInitial());

  void calculateStatistics(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      emit(StatisticsEmpty());
      return;
    }

    final categoryBreakdown = getCategoryBreakdownUseCase(transactions);
    final trend = getIncomeExpenseTrendUseCase(transactions);

    final totalIncome = transactions
        .where((t) => t.price > 0)
        .fold(0.0, (sum, t) => sum + t.price);
    final totalExpenses = transactions
        .where((t) => t.price < 0)
        .fold(0.0, (sum, t) => sum + t.price.abs());

    emit(StatisticsLoaded(
      categoryBreakdown: categoryBreakdown,
      trend: trend,
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      totalBalance: totalIncome - totalExpenses,
      transactionCount: transactions.length,
    ));
  }
}