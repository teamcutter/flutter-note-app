import 'package:flutter/material.dart';
import 'package:notes/models/note_database.dart';
import 'package:provider/provider.dart';
import 'pages/notes_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDatabase(),
      child: const NotesApp(),
    )
  );
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
    );
  }
}