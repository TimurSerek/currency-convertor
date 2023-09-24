import 'package:flutter/material.dart';
import 'core/di/injection_container.dart';
import 'features/currency/presentation/pages/home/currency_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrencyScreen(),
    );
  }
}

