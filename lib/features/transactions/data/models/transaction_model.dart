import 'package:isar_community/isar.dart';
import '../../domain/entities/transaction.dart';

part 'transaction_model.g.dart';

@collection
class TransactionModel {
  Id id = Isar.autoIncrement;

  late String productName;
  String? imageUrl;
  late String source;
  late DateTime date;
  late double price;
  late String category;

  TransactionModel();

  factory TransactionModel.fromEntity(Transaction entity) {
    final model = TransactionModel()
      ..productName = entity.productName
      ..imageUrl = entity.imageUrl
      ..source = entity.source
      ..date = entity.date
      ..price = entity.price
      ..category = entity.category;
    if (entity.id != null) {
      model.id = entity.id!;
    }
    return model;
  }

  Transaction toEntity() {
    return Transaction(
      id: id,
      productName: productName,
      imageUrl: imageUrl,
      source: source,
      date: date,
      price: price,
      category: category,
    );
  }
}
