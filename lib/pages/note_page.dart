import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key, required this.note});

  final Note note;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(note.title),
          Text(note.text),
        ],
      ),
    );
  }
  
}