import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../data/model/todo_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('auth.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2, // Đổi từ 1 lên 2 để kích hoạt onUpgrade
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Chạy khi app cài mới hoàn toàn
  Future<void> _onCreate(Database db, int version) async {
    // 1. Tạo bảng users
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    // Hardcode tài khoản mặc định
    await db.insert('users', {
      'username': 'admin',
      'password': 'password123',
    });

    // 2. Tạo bảng todos
    await _createTodosTable(db);
  }

  // Chạy khi phát hiện database hiện tại ở version cũ (< 2)
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _createTodosTable(db);
    }
  }

  Future<void> _createTodosTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS todos (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        isDone INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  // --- Auth operations ---
  Future<bool> checkLogin(String username, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty;
  }

  // --- Todo CRUD operations ---
  Future<List<TodoModel>> getTodos() async {
    final db = await instance.database;
    final result = await db.query('todos');
    return result.map((json) => TodoModel.fromMap(json)).toList();
  }

  Future<void> insertTodo(TodoModel todo) async {
    final db = await instance.database;
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTodoStatus(String id, bool isDone) async {
    final db = await instance.database;
    await db.update(
      'todos',
      {'isDone': isDone ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTodo(String id) async {
    final db = await instance.database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}