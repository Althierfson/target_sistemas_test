import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/data/datasources/notes/notes_data_source_local.dart';
import 'package:target_sistemas_test/domain/repositories/notes/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesDataSourceLocal dataSourceLocal;

  NotesRepositoryImpl({required this.dataSourceLocal});

  @override
  Future<Either<Failure, List<String>>> saveNotes(List<String> notes) async {
    try {
      final list = await dataSourceLocal.saveNotes(notes);
      return Right(list);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (error) {
      debugPrint(error.toString());
      return Left(UnexpectedError());
    }
  }

  @override
  Future<Either<Failure, List<String>>> fetchNotes() async {
    try {
      final list = await dataSourceLocal.fetchNotes();
      return Right(list);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnexpectedError());
    }
  }
}
