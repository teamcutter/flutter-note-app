import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/components/drawer.dart';
import 'package:notes/components/note_tile.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_database.dart';
import 'package:notes/pages/add_note_page.dart';
import 'package:notes/pages/update_note_page.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  void createNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNotePage(
          note: Note()
          ..title = 'Title'
          ..text = 'Your note here.'
          ..lastEdit = DateTime.now()
        ),
      ),
    );
  }

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void updateNote(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateNotePage(note: note)
      ),
    );
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {

    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Notes',
          style: GoogleFonts.archivo(
            fontSize: 30,
            color: Theme.of(context).colorScheme.inversePrimary
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.add),
      ),
      drawer: const CustomDrawer(),
      body: 
          Expanded(
            child: ListView.builder(
            itemCount: currentNotes.length,
            itemBuilder: (context, index) { 
              final note = currentNotes[index];
              return NoteTile(
                note: note, 
                updateNote: updateNote, 
                deleteNote: deleteNote
            );
          },
        ),
      ),
    );
  }
}