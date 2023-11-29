import 'package:dartz/dartz.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/domain/repositories/notes/notes_repository.dart';

class FetchNotes {
  final NotesRepository repository;

  FetchNotes({required this.repository});

  Future<Either<Failure, List<String>>> call() async {
    return await repository.fetchNotes();
  }
}
