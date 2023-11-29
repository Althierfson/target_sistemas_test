import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/domain/usecases/notes/fetch_notes.dart';

import '../../../test_values.dart';
import 'save_notes_test.mocks.dart';

void main() {
  late MockNotesRepository repository;
  late FetchNotes usecase;

  setUp(() {
    repository = MockNotesRepository();
    usecase = FetchNotes(repository: repository);
  });

  test("Should return a list of String on right side", () async {
    final list = getNotes();
    when(repository.fetchNotes()).thenAnswer((_) async => Right(list));

    final result = await usecase();

    expect(result, Right(list));
  });

  test("Should return a FetchNoteFailure  on Left side", () async {
    when(repository.fetchNotes())
        .thenAnswer((_) async => Left(FetchNoteFailure()));

    final result = await usecase();

    expect(result, Left(FetchNoteFailure()));
  });
}
