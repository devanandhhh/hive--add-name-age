import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:week_7_activities/details.dart';
import 'package:week_7_activities/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DetailsAdapter());
  await Hive.openBox<Details>('details');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
