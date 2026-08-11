class CategoryStat {
  final String category;
  final double amount;
  final double percentage;
  final int color; // قيمة ARGB

  const CategoryStat({
    required this.category,
    required this.amount,
    required this.percentage,
    required this.color,
  });
}