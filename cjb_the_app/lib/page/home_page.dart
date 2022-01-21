import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import '../db/goals_database.dart';
import 'add_goal_page.dart';
import '../goal.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  // int _counter = 0;
  //
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }


  late List<Goal> goals;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshGoals();
  }


  @override
  void dispose() {
    GoalsDatabase.instance.close();

    super.dispose();
  }

  Future refreshGoals() async {
    setState(() => isLoading = true);

    this.goals = await GoalsDatabase.instance.readAllGoals();

    setState(() => isLoading = false);
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontSize: 24)),
      ),

      body: Center(

        child: isLoading
            ? CircularProgressIndicator()
            : goals.isEmpty
              ? Text('No Goals')
              : buildGoals(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _pushAddGoal,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {


                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Widget buildGoals() => ListView(
    padding: EdgeInsets.all(8),
    children: goals.map((goal) => Container(
        height: 50,
        color: Colors.red,
        child: const Center(child: Text(goal.description)),
      )).toList()


  );

  void _pushAddGoal() async {
    await Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (context) => AddGoal())
    );

    refreshGoals();
  }
}