import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import '../db/goals_database.dart';
import 'home_page.dart';


class AddGoal extends StatelessWidget {
  final goalController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();


  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Add new goal'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: goalController,
              decoration: InputDecoration(
                  hintText: 'Goal'
              ),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                  hintText: 'Description'
              ),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                  hintText: 'Due Date (number)'
              ),
            ),
            TextField(
              controller: monthController,
              decoration: InputDecoration(
                  hintText: 'Due Month (number 0-12)'
              ),
            ),
            TextField(
              controller: yearController,
              decoration: InputDecoration(
                  hintText: 'Due Year (number)'
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },

        child: Icon(Icons.add),
      ),
    );

  }


  DateTime date_maker(String day, String month, String year) {

    return DateTime.parse("$year-$month-$day");
  }

}
