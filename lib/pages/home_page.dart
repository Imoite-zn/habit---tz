import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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