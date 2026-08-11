import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserLocalStorageService {
  // فحص وإنشاء مجلد حفظ الصور الخاص بالتطبيق
  Future<void> initImageDirectory() async {
    try {
      // جلب مسار التخزين الداخلي الآمن للتطبيق
      final dir = await getApplicationDocumentsDirectory();
      final imagesDir = Directory("${dir.path}/images");

      // إنشاء المجلد إذا لم يكن موجوداً
      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }
    } catch (e) {
      // طباعة الخطأ في حال فشل العملية لتفادي انهيار التطبيق
      print("Error creating images directory: $e");
    }
  }
}