import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final void Function(Note) updateNote;
  final void Function(int) deleteNote;
  const NoteTile({
    super.key, 
    required this.note, 
    required this.updateNote,
    required this.deleteNote,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
        title: Text(note.text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => updateNote(note), 
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () => deleteNote(note.id), 
              icon: const Icon(Icons.delete)
            ),
          ],
        ),
      ),
    );
  }
}