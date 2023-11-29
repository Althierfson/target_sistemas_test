import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/data/datasources/notes/notes_data_source_local.dart';
import 'package:target_sistemas_test/data/repositories/notes/notes_repository_impl.dart';

import '../../../test_values.dart';
import 'note_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NotesDataSourceLocal>()])
void main() {
  late MockNotesDataSourceLocal dataSourceLocal;
  late NotesRepositoryImpl repository;

  setUpAll(() {
    dataSourceLocal = MockNotesDataSourceLocal();
    repository = NotesRepositoryImpl(dataSourceLocal: dataSourceLocal);
  });

  group("Function saveNotes", () {
    test("Should return a list of String on the Right side", () async {
      final list = getNotes();
      when(dataSourceLocal.saveNotes(list)).thenAnswer((_) async => list);

      final result = await repository.saveNotes(list);

      expect(result, Right(list));
    });

    test(
        "Should return a SaveNoteFailure on the Left side when datasourcelocal throw a Failure",
        () async {
      final list = getNotes();
      when(dataSourceLocal.saveNotes(list)).thenThrow(SaveNoteFailure());

      final result = await repository.saveNotes(list);

      expect(result, Left(SaveNoteFailure()));
    });

    test(
        "Should return a UnexpectedError on the Left side when datasourcelocal throw any Exception",
        () async {
      final list = getNotes();
      when(dataSourceLocal.saveNotes(list)).thenThrow(Exception());

      final result = await repository.saveNotes(list);

      expect(result, Left(UnexpectedError()));
    });
  });

  group("Function fetchNotes", () {
    test("Should return a list of String on the Right side", () async {
      final list = getNotes();
      when(dataSourceLocal.fetchNotes()).thenAnswer((_) async => list);

      final result = await repository.fetchNotes();

      expect(result, Right(list));
    });

    test(
        "Should return a FetchNoteFailure on the Left side when datasourcelocal throw a Failure",
        () async {
      when(dataSourceLocal.fetchNotes()).thenThrow(FetchNoteFailure());

      final result = await repository.fetchNotes();

      expect(result, Left(FetchNoteFailure()));
    });

    test(
        "Should return a UnexpectedError on the Left side when datasourcelocal throw any Exception",
        () async {
      when(dataSourceLocal.fetchNotes()).thenThrow(Exception());

      final result = await repository.fetchNotes();

      expect(result, Left(UnexpectedError()));
    });
  });
}
