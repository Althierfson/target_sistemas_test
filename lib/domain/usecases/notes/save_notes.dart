import 'package:dartz/dartz.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/domain/repositories/notes/notes_repository.dart';

class SaveNotes {
  final NotesRepository repository;

  SaveNotes({required this.repository});

  Future<Either<Failure, List<String>>> call(List<String> list) async {
    return await repository.saveNotes(list);
  }
}
