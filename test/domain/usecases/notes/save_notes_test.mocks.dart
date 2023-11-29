// Mocks generated by Mockito 5.4.3 from annotations
// in target_sistemas_test/test/domain/usecases/notes/save_notes_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:target_sistemas_test/core/failures.dart' as _i5;
import 'package:target_sistemas_test/domain/repositories/notes/notes_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NotesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotesRepository extends _i1.Mock implements _i3.NotesRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<String>>> saveNotes(
          List<String>? notes) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveNotes,
          [notes],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<String>>>.value(
            _FakeEither_0<_i5.Failure, List<String>>(
          this,
          Invocation.method(
            #saveNotes,
            [notes],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, List<String>>>.value(
                _FakeEither_0<_i5.Failure, List<String>>(
          this,
          Invocation.method(
            #saveNotes,
            [notes],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<String>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<String>>> fetchNotes() =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchNotes,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<String>>>.value(
            _FakeEither_0<_i5.Failure, List<String>>(
          this,
          Invocation.method(
            #fetchNotes,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, List<String>>>.value(
                _FakeEither_0<_i5.Failure, List<String>>(
          this,
          Invocation.method(
            #fetchNotes,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<String>>>);
}
