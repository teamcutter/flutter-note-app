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
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Define FocusNode
  String _searchQuery = '';

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
            ..lastEdit = DateTime.now(),
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
      MaterialPageRoute(builder: (context) => UpdateNotePage(note: note)),
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

  void _searchNotes(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void toggleKeyboardVisibility() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus(); // Hide keyboard
    } else {
      FocusScope.of(context).requestFocus(_focusNode); // Show keyboard
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;

    if (_searchQuery.isNotEmpty) {
      currentNotes = currentNotes.where((note) {
        final title = note.title.toLowerCase();
        final text = note.text.toLowerCase();
        final query = _searchQuery.toLowerCase();
        return title.contains(query) || text.contains(query);
      }).toList();
    }

    currentNotes.sort((a, b) => b.lastEdit.compareTo(a.lastEdit));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: _selectedNotes.isNotEmpty
            ? Text(
                'Delete ${_selectedNotes.length} items',
                style: GoogleFonts.archivo(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              )
            : TextField(
                focusNode: _focusNode, // Attach FocusNode
                controller: _searchController,
                onChanged: _searchNotes,
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                  suffixIcon: _searchQuery.isEmpty ?
                  IconButton(
                    onPressed: () {
                      _searchNotes(_searchController.text);
                      toggleKeyboardVisibility();
                    },
                    icon: const Icon(Icons.search),
                  )
                  :
                  IconButton(
                    onPressed: () {
                      _searchController.text = '';
                      _searchNotes('');
                      toggleKeyboardVisibility();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
        actions: _selectedNotes.isNotEmpty
            ? [
                IconButton(
                  onPressed: () {
                    for (var note in _selectedNotes) {
                      deleteNote(note.id);
                    }
                    setState(() {
                      _selectedNotes.clear();
                    });
                  },
                  icon: const Icon(Icons.delete),
                )
              ]
            : [],
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
