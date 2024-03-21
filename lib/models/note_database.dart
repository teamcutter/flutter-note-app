import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:notes/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {

  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  final List<Note> currentNotes = [];

  Future<void> addNote(String title, String text) async {
    final newNote = Note();
    newNote.text = text;
    newNote.title = title;
    newNote.lastEdit = DateTime.now();
    await isar.writeTxn(() => isar.notes.put(newNote));
    await fetchNotes();
  }

  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    fetchedNotes.sort((a, b) => b.lastEdit.compareTo(a.lastEdit));
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> updateNote(int id, String title, String text) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.title = title;
      existingNote.text = text;
      existingNote.lastEdit = DateTime.now();
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}