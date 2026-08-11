import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar_community/isar.dart';
import 'package:khazna/core/data/datasources/ImageDirectoryInitializer.dart';
import 'package:khazna/core/presentation/pages/main_shell.dart';
import 'package:khazna/features/transactions/data/models/transaction_model.dart';
import 'package:khazna/service_locator.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ImageDirectoryInitializerImpl().initialDirectory();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([TransactionModelSchema], directory: dir.path);
  sl.registerSingleton<Isar>(isar);
  await initServiceLocator();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFFF7FDF9),
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarContrastEnforced: false,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF5F7FA)),
      ),
      builder: (context, child) {
        return Column(
          children: [
            Expanded(child: child!),
            Container(
              color: const Color(0xFFF5F7FA),
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        );
      },
      home: const MainShell(),
    );
  }
}