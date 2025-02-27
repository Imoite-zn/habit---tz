import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 1,
      ),
      drawer: MyDrawer(),
    );
  }
}