import 'package:khazna/features/statistics/domain/entities/category_stat.dart';
import 'package:khazna/features/statistics/domain/entities/trend_point.dart';

abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}

class StatisticsEmpty extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final List<CategoryStat> categoryBreakdown;
  final List<TrendPoint> trend;
  final double totalIncome;
  final double totalExpenses;
  final double totalBalance;
  final int transactionCount;

  StatisticsLoaded({
    required this.categoryBreakdown,
    required this.trend,
    required this.totalIncome,
    required this.totalExpenses,
    required this.totalBalance,
    required this.transactionCount,
  });
}