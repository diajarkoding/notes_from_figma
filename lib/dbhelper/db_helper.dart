import 'package:notes_from_figma/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? _database;

  Future<Database?> get dbInstance async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
    return _database;
  }

  initDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'notesdb.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, body TEXT)',
        );
      },
    );
  }

  Future<List<NoteModel>> getNotes() async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps = await db!.query('notes');

    return List.generate(
      maps.length,
      (i) {
        return NoteModel(
          id: maps[i]['id'],
          title: maps[i]['title'],
          body: maps[i]['body'],
        );
      },
    );
  }

  Future<void> saveNote(NoteModel note) async {
    final db = await dbInstance;

    await db!.insert('notes', note.toMap());
  }

  Future<void> deleteNote(noteId) async {
    final db = await dbInstance;

    await db!.delete('notes', where: 'id = ?', whereArgs: [noteId]);
  }

  Future<void> updateNote(NoteModel note) async {
    final db = await dbInstance;
    await db!
        .update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }
}
