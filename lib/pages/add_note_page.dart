import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_database.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key, required this.note});

  final Note note;
  
  @override
  State<StatefulWidget> createState() => _NotesPageState();
}

class _NotesPageState extends State<AddNotePage> {

  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<NoteDatabase>().addNote(_titleController.text, _textController.text);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: TextField(
                maxLines: null,
                autofocus: true,
                style: GoogleFonts.dmSerifText(
                  fontSize: 36,
                  color: Theme.of(context).colorScheme.inversePrimary
                ),
                decoration: InputDecoration.collapsed(
                  hintText: widget.note.title
                ),
                controller: _titleController,
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            Expanded(
              // Body text
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
                child: TextField(
                    maxLines: null,
                    style: GoogleFonts.dmSerifText(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary
                  ),
                    decoration: InputDecoration.collapsed(
                    hintText: widget.note.text
                  ),
                  controller: _textController,
                  cursorColor: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}