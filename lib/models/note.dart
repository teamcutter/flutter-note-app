import 'package:isar/isar.dart';

// generate file run: dart run build_runner build
part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String title;
  late String text;
  late DateTime lastEdit;
}