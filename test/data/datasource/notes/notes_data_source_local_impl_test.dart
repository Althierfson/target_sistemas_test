import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/data/datasources/notes/notes_data_source_local_impl.dart';

import '../../../test_values.dart';
import '../login/login_data_source_local_impl_test.mocks.dart';

void main() {
  late MockSharedPreferences shared;
  late NotesDataSourceLocalImpl dataSource;

  setUp(() {
    shared = MockSharedPreferences();
    dataSource = NotesDataSourceLocalImpl(shared: shared);
  });

  group("Function saveNotes", () {
    test("Should return [String] list when List is saved", () async {
      final list = getNotes();
      when(shared.setStringList("_notesListKey", list))
          .thenAnswer((_) async => true);
      when(shared.getStringList("_notesListKey")).thenReturn(list);

      final result = await dataSource.saveNotes(list);

      expect(result, list);
    });

    test("Should throw [SaveNotesFailure] when list is not saved", () async {
      final list = getNotes();
      when(shared.setStringList("_notesListKey", list)).thenThrow(Exception());

      expect(() => dataSource.saveNotes(list), throwsA(isA<SaveNoteFailure>()));
    });
  });

  group("Function fechNotes", () {
    test("Should return [String] list", () async {
      final list = getNotes();
      when(shared.getStringList("_notesListKey")).thenReturn(list);

      final result = await dataSource.fetchNotes();

      expect(result, list);
    });

    test("Should throw [FetchNoteFailure] when is not possible get list",
        () async {
      final list = getNotes();
      when(shared.getStringList("_notesListKey")).thenThrow(Exception());

      expect(
          () => dataSource.saveNotes(list), throwsA(isA<FetchNoteFailure>()));
    });
  });
}
