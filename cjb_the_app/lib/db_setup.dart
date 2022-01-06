import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'goal.dart';


class GoalsDatabase {
  static final GoalsDatabase instance = GoalsDatabase._init();

  static Database?  _database;

  GoalsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('goals.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableGoals (
  ${GoalFields.id} $idType,
  ${GoalFields.goal} $textType,
  ${GoalFields.description} $textType,
  ${GoalFields.dueDate} $textType
)
    ''');
  }

  Future<Goal> create(Goal goal) async {
    final db = await instance.database;

    final id = await db.insert(tableGoals, goal.toJson());

    return goal.copy(id: id);

  }

  Future<Goal> readGoal(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableGoals,
      columns: GoalFields.values,
      where: '${GoalFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Goal.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }

  }


  Future<List<Goal>> readAllGoals() async {
    final db = await instance.database;

    final orderBy = '${GoalFields.dueDate} ASC';
    final result = await db.query(tableGoals, orderBy: orderBy);

    return result.map((json) => Goal.fromJson(json)).toList();
  }

  Future<int> update(Goal goal) async {
    final db = await instance.database;

    return db.update(
      tableGoals,
      goal.toJson(),
      where: '${GoalFields.id} = ?',
      whereArgs: [goal.id]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableGoals,
      where: '${GoalFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}