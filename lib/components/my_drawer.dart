// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';

//drawer doesnt require to be stateful
class MyDrawer extends StatelessWidget {
   MyDrawer({
    super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          Center(
            child: DrawerHeader(
              child: Text(
                'Habi - TZ',
                style: TextStyle(
                  fontSize: 30, 
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  ),
                ),
            ),
          ),
          ListTile(
            trailing: CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context).isDarkMode, 
              onChanged: (value) =>
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
              ),
          )
          ],
          ),
    );
  }
}