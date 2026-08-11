import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// واجهة مجردة لتهيئة مجلد حفظ الصور
abstract class ImageDirectoryInitializer {
  /// تهيئة مجلد الصور (إنشاؤه إذا لم يكن موجودًا)
  Future<void> initialDirectory();
}

/// تنفيذ واجهة تهيئة مجلد الصور
class ImageDirectoryInitializerImpl implements ImageDirectoryInitializer {
  @override
  Future<void> initialDirectory() async {
    // الحصول على مسار مجلد المستندات الخاص بالتطبيق
    final appDir = await getApplicationDocumentsDirectory();

    // تحديد مسار مجلد الصور داخل مجلد المستندات
    final imageDir = Directory('${appDir.path}/images');

    // التحقق من عدم وجود المجلد مسبقًا
    if (!await imageDir.exists()) {
      // إنشاء المجلد مع أي مجلدات فرعية غير موجودة (recursive)
      await imageDir.create(recursive: true);
    }
  }
}