import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:notes/models/note.dart';


class NoteTile extends StatefulWidget {
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
  State<StatefulWidget> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
        title: Text(widget.note.title),
        subtitle: Text('Edited ${Jiffy.parseFromDateTime(widget.note.lastEdit).MMMd}'),
        onTap: () => widget.updateNote(widget.note),
        onLongPress: () => widget.deleteNote(widget.note.id),
      ),
    );
  }

}