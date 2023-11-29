import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/domain/repositories/notes/notes_repository.dart';
import 'package:target_sistemas_test/domain/usecases/notes/save_notes.dart';

import '../../../test_values.dart';
import 'save_notes_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NotesRepository>()])
void main() {
  late MockNotesRepository repository;
  late SaveNotes usecase;

  setUp(() {
    repository = MockNotesRepository();
    usecase = SaveNotes(repository: repository);
  });

  test("Should return a list of String on right side", () async {
    final list = getNotes();
    when(repository.saveNotes(list)).thenAnswer((_) async => Right(list));

    final result = await usecase(list);

    expect(result, Right(list));
  });

  test("Should return a SaveNoteFailure on Left side", () async {
    final list = getNotes();
    when(repository.saveNotes(list))
        .thenAnswer((_) async => Left(SaveNoteFailure()));

    final result = await usecase(list);

    expect(result, Left(SaveNoteFailure()));
  });
}
