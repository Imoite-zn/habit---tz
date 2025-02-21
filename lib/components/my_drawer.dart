import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
          ListTile()
          ],
          ),
    );
  }
}