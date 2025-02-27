import 'package:flutter/material.dart';
import 'package:habit_tracker/database/habit_db.dart';
import 'package:habit_tracker/pages/home_page.dart';
import 'package:habit_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //initialize db
  await HabitDb.initialize();
  await HabitDb().saveFirstLaunchDate();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        ),
      ChangeNotifierProvider(
        create: (context) => HabitDb(),
        ),
    ],
    child: const MyApp()
    ),
    );
    
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: HomePage(),
    );
  }
}
