import 'package:khazna/features/statistics/domain/entities/trend_point.dart';
import 'package:khazna/features/transactions/domain/entities/transaction.dart';

/// يحسب الدخل/المصروف لآخر 7 أيام يوماً بيوم
class GetIncomeExpenseTrendUseCase {
  List<TrendPoint> call(List<Transaction> transactions) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final days = List.generate(7, (i) => today.subtract(Duration(days: 6 - i)));

    return days.map((day) {
      final dayTransactions = transactions.where((t) {
        final d = DateTime(t.date.year, t.date.month, t.date.day);
        return d == day;
      });

      final income = dayTransactions
          .where((t) => t.price > 0)
          .fold(0.0, (sum, t) => sum + t.price);
      final expense = dayTransactions
          .where((t) => t.price < 0)
          .fold(0.0, (sum, t) => sum + t.price.abs());

      return TrendPoint(label: _weekdayLabel(day.weekday), income: income, expense: expense);
    }).toList();
  }

  String _weekdayLabel(int weekday) {
    const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return labels[weekday - 1];
  }
}