import 'package:flutter/cupertino.dart';
import 'package:habit_tracker/models/app_settings.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDb extends ChangeNotifier {
  static late Isar isar;

  /*

   SETUP

  */

  //INITIALIZE DATABASE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema], 
      directory: dir.path,
      );
  }

  //save first date of app startup (for heatmap)
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
  }
  }
  //get first date of app startup (for heatmap)
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  /*
  CRUD OPERATIONS
  */

  //List of habits
  final List<Habit> currentHabits = [];

  //CREATE add new habit
  Future<void> addHabit(String habitName) async {
    //create new habit
    final newHabit = Habit()..name = habitName;

    //save to db
    await isar.writeTxn(() => isar.habits.put(newHabit));

    //re-read from db
    readHabits();
  }

  //READ read saved habits
  Future<void> readHabits() async {
    //fetch all habits from db
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    //give to currrent habits
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    //update UI
    notifyListeners();

  }

  //UPDATE - check habit on and off
  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    //find specific habit
    final habit = await isar.habits.get(id);

    //update completion status
    if(habit != null ) {
      await isar.writeTxn(()async{
        //if habit is  completed -> add current date to completedDays List
        if(isCompleted && !habit.completedDays.contains(DateTime.now())) {
          //today
          final today = DateTime.now();

          //add the current date if it is not already in list
          habit.completedDays.add(
            DateTime(
              today.year,
              today.month,
              today.day
            )
          );
        }

        //if habit is Not completed -> remove the current date from the list
        else {
          //remove current date if habit is marked as not completed
          habit.completedDays.removeWhere((date) => 
          date.year == DateTime.now().year &&
          date.month == DateTime.now().month &&
          date.day == DateTime.now().day,
          );
        } 
        //save the updated habits from db
        await isar.habits.put(habit);
      });
    }

    //re-read from db
    readHabits();
  }
  //UPDATE - edit habit name
  Future<void> editHabitName(int id, String newHabitName) async {
    //Find the specific habit
    final habit = await isar.habits.get(id);

    //update the habit name
    if(habit != null) {
      await isar.writeTxn(()async{
        //update the habit name
        habit.name = newHabitName;
        //save the updated habit
        await isar.habits.put(habit);
      });
    }

    readHabits();
  }

  //DELETE delete habit
  Future<void> deleteHabit(int id) async {
    //perform deletion
    await isar.writeTxn(()async{
      //delete the habit
      await isar.habits.delete(id);
      });

      readHabits();
  }

}