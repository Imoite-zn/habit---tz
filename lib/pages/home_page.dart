import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_drawer.dart';
import 'package:habit_tracker/database/habit_db.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 //text controller
  final TextEditingController textContoller = TextEditingController();
  //create new habit
  void createNewHabit () {
    //show dialog to input habit name
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          content: TextField(
            controller: textContoller,
            decoration: InputDecoration(
              hintText: 'Create new habit'),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  //dismiss dialog
                  Navigator.of(context).pop();

                  textContoller.clear();
                  },
                  child: Text('Cancel'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      //dismiss dialog and create new habit
                      Navigator.of(context).pop();
                      //create new habit logic here
                      String newHabitName = textContoller.text;

                      //save to db
                      context.read<HabitDb>().addHabit(newHabitName);

                      //clear text controller
                      textContoller.clear();
                      },
                      child: Text('Save'),
                      ),
                      ],
                      )
                      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: createNewHabit,
        child: Icon(Icons.add),
        ),
    );
  }
}