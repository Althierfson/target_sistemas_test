import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/data/datasources/notes/notes_data_source_local.dart';

class NotesDataSourceLocalImpl implements NotesDataSourceLocal {
  final SharedPreferences shared;

  NotesDataSourceLocalImpl({required this.shared});

  final String _notesListKey = "_notesListKey";

  @override
  Future<List<String>> saveNotes(List<String> notes) async {
    try {
      await shared.setStringList(_notesListKey, notes);
      return fetchNotes();
    } catch (e) {
      debugPrint(e.toString());
      throw SaveNoteFailure();
    }
  }

  @override
  Future<List<String>> fetchNotes() async {
    try {
      return shared.getStringList(_notesListKey) ?? [];
    } catch (e) {
      debugPrint(e.toString());
      throw FetchNoteFailure();
    }
  }
}
