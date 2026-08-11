class Transaction {
  final int? id;
  final String productName;
  final String? imageUrl;
  final String source;
  final DateTime date;
  final double price;
  final String category;

  Transaction({
    this.id,
    required this.productName,
    required this.imageUrl,
    required this.source,
    required this.date,
    required this.price,
    required this.category,
  });
}
