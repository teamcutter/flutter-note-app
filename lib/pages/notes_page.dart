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
  
  final List<Note> _selectedNotes = [];

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  void createNote() {
    setState(() {
      _selectedNotes.clear();
    });
    
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

  void toggleSelection(Note note) {
    setState(() {
      if (_selectedNotes.contains(note)) {
        _selectedNotes.remove(note);
      } else {
        _selectedNotes.add(note);
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {

    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;
    currentNotes.sort((a, b) => b.lastEdit.compareTo(a.lastEdit));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          _selectedNotes.isNotEmpty ? 
          'Delete ${_selectedNotes.length} items'
          : 'Notes',
          style: GoogleFonts.archivo(
            fontSize: 30,
            color: Theme.of(context).colorScheme.inversePrimary
          ),
        ),
        actions: _selectedNotes.isNotEmpty? [
          IconButton(
            onPressed: () {
              for (var note in _selectedNotes) {
                deleteNote(note.id);
              }
              setState(() {
                _selectedNotes.clear();
              });
            }, 
            icon: const Icon(Icons.delete)
          )
        ] : [],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(Icons.add),
      ),
      drawer: const CustomDrawer(),
      body: ListView.builder(
          itemCount: currentNotes.length,
          itemBuilder: (context, index) { 
            final note = currentNotes[index];
            return NoteTile(
              note: note,  
              deleteNote: deleteNote,
              isSelected: _selectedNotes.contains(note),
              onLongPress: () {
                toggleSelection(note);
              },
              onTap: () {
                if (_selectedNotes.isNotEmpty) {
                  toggleSelection(note);
                } else {
                  updateNote(note);
                }
              },
          );
        },
      ),
    );
  }
}