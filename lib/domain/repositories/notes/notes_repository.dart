import 'package:dartz/dartz.dart';
import 'package:target_sistemas_test/core/failures.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<String>>> saveNotes(List<String> notes);
  Future<Either<Failure, List<String>>> fetchNotes();
}
