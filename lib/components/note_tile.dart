import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:notes/models/note.dart';


class NoteTile extends StatefulWidget {
  final Note note;
  final void Function(int) deleteNote;
  final void Function() onLongPress;
  final void Function() onTap;
  final bool isSelected;
  const NoteTile({
    super.key, 
    required this.note, 
    required this.deleteNote,
    required this.isSelected, 
    required this.onLongPress, 
    required this.onTap
  });
  
  @override
  State<StatefulWidget> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: !widget.isSelected ? 
        Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
        title: widget.note.title.length > 20
        ? Text("${widget.note.title.substring(0, 20)}...")
        : Text(widget.note.title),
        subtitle: Text('Edited ${Jiffy.parseFromDateTime(widget.note.lastEdit).MMMd}'),
        onTap: () => widget.onTap(),
        onLongPress: () => widget.onLongPress(),
      ),
    );
  }
}