import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/domain/usecases/notes/fetch_notes.dart';
import 'package:target_sistemas_test/domain/usecases/notes/save_notes.dart';
import 'package:target_sistemas_test/presentation/mobx/notes/notes_store.dart';

import '../../../test_values.dart';
import 'notes_store_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchNotes>(), MockSpec<SaveNotes>()])
void main() {
  late MockFetchNotes fetchNotes;
  late MockSaveNotes saveNotes;
  late NotesStore store;

  setUp(() {
    fetchNotes = MockFetchNotes();
    saveNotes = MockSaveNotes();
    store = NotesStore(fetchNotes: fetchNotes, saveNotes: saveNotes);
  });

  group("usecase saveNotes", () {
    test(
        "When the empty value was inserted, the error field should have the error message",
        () async {
      expect(store.notes.isEmpty, true);
      expect(store.noteSelected, null);

      store.updateNotes("");

      expect(store.notes, []);
      expect(store.error, "Não é possivel adicionar um valor vazio.");
    });

    test("Should add a new item to the list and save it", () async {
      final list = ["Note 1"];

      when(saveNotes(list)).thenAnswer((_) async => Right(list));

      expect(store.notes.isEmpty, true);
      expect(store.noteSelected, null);

      store.updateNotes("Note 1");

      await Future.delayed(const Duration(seconds: 2));

      expect(store.notes, ["Note 1"]);
    });

    test("Should edit a item from the list and save it", () async {
      store.notes = ["Note 1"];
      final list = ["Note 1 edit"];

      when(saveNotes(list)).thenAnswer((_) async => Right(list));

      expect(store.notes, ["Note 1"]);

      store.noteSelected = 0;
      store.updateNotes("Note 1 edit");

      await Future.delayed(const Duration(seconds: 2));

      expect(store.notes, ["Note 1 edit"]);
      expect(store.noteSelected, null);
    });

    test("Should remove a item from the list and save it", () async {
      store.notes = ["Note 1"];
      final list = <String>[];

      when(saveNotes(list)).thenAnswer((_) async => Right(list));

      expect(store.notes, ["Note 1"]);

      store.removeNote(0);

      await Future.delayed(const Duration(seconds: 2));

      expect(store.notes, <String>[]);
    });

    test("When an updateNote fails, the error field should save the message",
        () async {
      store.notes = ["Note 1"];
      final list = ["Note 1 edit"];

      when(saveNotes(list)).thenAnswer((_) async => Left(SaveNoteFailure()));

      expect(store.notes, ["Note 1"]);

      store.noteSelected = 0;
      store.updateNotes("Note 1 edit");

      await Future.delayed(const Duration(seconds: 2));

      expect(store.notes, ["Note 1"]);
      expect(store.noteSelected, null);
      expect(store.error, SaveNoteFailure().message);
    });

    test("When an removeNote fails, the error field should save the message",
        () async {
      store.notes = ["Note 1"];

      when(saveNotes([])).thenAnswer((_) async => Left(SaveNoteFailure()));

      expect(store.notes, ["Note 1"]);

      store.noteSelected = 0;
      store.removeNote(0);

      await Future.delayed(const Duration(seconds: 2));

      expect(store.notes, ["Note 1"]);
      expect(store.error, SaveNoteFailure().message);
    });
  });

  group("usecase fetchNotes", () {
    test("Should bring the list of saved items", () async {
      final list = getNotes();
      when(fetchNotes()).thenAnswer((_) async => Right(list));

      expect(store.notes.isEmpty, true);

      store.fetchNotesList();

      await Future.delayed(const Duration(seconds: 2));

      expect(store.notes, list);
    });

    test(
        "When an fetchNotesList fails, the error field should save the message",
        () async {
      when(fetchNotes()).thenAnswer((_) async => Left(FetchNoteFailure()));

      expect(store.notes.isEmpty, true);

      store.fetchNotesList();

      await Future.delayed(const Duration(seconds: 2));

      expect(store.notes.isEmpty, true);
      expect(store.error, FetchNoteFailure().message);
    });
  });
}
