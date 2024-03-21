import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_database.dart';
import 'package:provider/provider.dart';

class UpdateNotePage extends StatefulWidget {
  const UpdateNotePage({super.key, required this.note});

  final Note note;
  
  @override
  State<StatefulWidget> createState() => _NotesPageState();
}

class _NotesPageState extends State<UpdateNotePage> {

  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        context.read<NoteDatabase>().updateNote(
          widget.note.id, 
          _titleController.text, 
          _textController.text
        );
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
                style: GoogleFonts.archivo(
                  fontSize: 36,
                  color: Theme.of(context).colorScheme.inversePrimary
                ),
                decoration: const InputDecoration.collapsed(
                  hintText: ''
                ),
                controller: _titleController..text = widget.note.title,
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            Expanded(
              // Body text
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
                child: TextField(
                    maxLines: null,
                    style: GoogleFonts.archivo(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary
                  ),
                    decoration: const InputDecoration.collapsed(
                    hintText: ''
                  ),
                  controller: _textController..text = widget.note.text,
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