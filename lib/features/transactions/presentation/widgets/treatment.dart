import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khazna/features/transactions/domain/entities/transaction.dart';

/// بطاقة تمثّل عنصر معاملة واحدة (Transaction Card)
///
/// تعرض صورة المنتج (أو أيقونة افتراضية)، اسم المنتج، المصدر، التاريخ،
/// السعر، وفئة المعاملة داخل بطاقة خضراء بتصميم موحد.
class Treatment extends StatelessWidget {
  final Transaction transaction;

  const Treatment({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final Color statusColor = transaction.price < 0
        ? const Color(0xFFFF6B6B)
        : const Color(0xFF2ECC71);
    final double absolutePrice = transaction.price.abs();
    // 1. تنسيق الرقم أولاً بحجمه وفواصله
    final String formattedPrice = NumberFormat(
      '#,##0.00',
      'en_US',
    ).format(absolutePrice);

    // تركيب النص: الإشارة أولاً، ثم الـ $، ثم الرقم المنسق
    final String displayText = transaction.price > 0
        ? '+\$$formattedPrice'
        : (transaction.price < 0 ? '-\$$formattedPrice' : '\$$formattedPrice');

    // التحقق من وجود مسار صورة صالح وأن الملف موجود فعلياً على الجهاز
    final bool hasValidImage =
        transaction.imageUrl != null &&
        transaction.imageUrl!.isNotEmpty &&
        File(transaction.imageUrl!).existsSync();

    return Card(
      // elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: Colors.white,
      child: Row(
        children: [
          Row(
            children: [
              // صورة المنتج داخل بطاقة دائرية الحواف
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
                margin: EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  // عرض الصورة الفعلية إن وُجدت، وإلا أيقونة إيصال افتراضية
                  child: hasValidImage
                      ? Image.file(
                          File(transaction.imageUrl!),
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.receipt_long, color: statusColor, size: 64),
                ),
              ),

              // عمود المعلومات النصية: اسم المنتج، المصدر، التاريخ
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // اسم المنتج (سطر واحد مع اقتطاع بـ "...")
                  Container(
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(
                      maxWidth: 88,
                      minWidth: 88,
                    ),
                    child: Text(
                      maxLines: 1,
                      transaction.productName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                        height: 1.0,
                      ),
                    ),
                  ),

                  SizedBox(height: 4),

                  // مصدر المعاملة (سطر واحد مع اقتطاع بـ "...")
                  Container(
                    alignment: Alignment.centerLeft,
                    constraints: const BoxConstraints(
                      maxWidth: 88,
                      minWidth: 88,
                    ),
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      transaction.source,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: statusColor,
                        height: 1.0,
                      ),
                    ),
                  ),

                  SizedBox(height: 4, width: 12),

                  // تاريخ المعاملة بصيغة dd/MM/yyyy
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    DateFormat('dd/MM/yyyy').format(transaction.date),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: statusColor,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 40),
          // عمود السعر والفئة، محاذى لليمين
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // السعر منسّق كعملة بفاصلين عشريين
                Container(
                  constraints: BoxConstraints(maxWidth: 104),
                  alignment: Alignment.centerRight,
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    displayText,
                    /**"+\$${(NumberFormat('#,##0', 'en_US')
  ..minimumFractionDigits = (transaction.price % 1 != 0) ? 2 : 0
  ..maximumFractionDigits = 2)
  .format(transaction.price)}", */
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                      height: 1.0,
                    ),
                  ),
                ),

                SizedBox(height: 8),
                // شارة (badge) صغيرة تعرض فئة المعاملة
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 88,
                    maxHeight: 32,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      transaction.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF7FDF9),
                        letterSpacing: 0.3,
                        height: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
