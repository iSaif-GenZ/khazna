import 'package:khazna/features/statistics/domain/entities/category_stat.dart';
import 'package:khazna/features/transactions/domain/entities/transaction.dart';

/// يحسب توزيع المصروفات على الفئات (Categories) كنسب مئوية
class GetCategoryBreakdownUseCase {
  static const List<int> _palette = [
    0xFF2ECC71,
    0xFFFF6B6B,
    0xFFFFC145,
    0xFF4D96FF,
    0xFFB983FF,
    0xFF27A45B,
  ];

  List<CategoryStat> call(List<Transaction> transactions) {
    final expenses = transactions.where((t) => t.price < 0).toList();
    if (expenses.isEmpty) return [];

    final Map<String, double> totals = {};
    for (final t in expenses) {
      final key = t.category.isEmpty ? "Other" : t.category;
      totals[key] = (totals[key] ?? 0) + t.price.abs();
    }

    final totalAmount = totals.values.fold(0.0, (a, b) => a + b);
    final entries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return List.generate(entries.length, (i) {
      final entry = entries[i];
      return CategoryStat(
        category: entry.key,
        amount: entry.value,
        percentage: totalAmount == 0 ? 0 : (entry.value / totalAmount) * 100,
        color: _palette[i % _palette.length],
      );
    });
  }
}