// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotesStore on _NotesStore, Store {
  late final _$notesAtom = Atom(name: '_NotesStore.notes', context: context);

  @override
  List<String> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(List<String> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$errorAtom = Atom(name: '_NotesStore.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$noteSelectedAtom =
      Atom(name: '_NotesStore.noteSelected', context: context);

  @override
  int? get noteSelected {
    _$noteSelectedAtom.reportRead();
    return super.noteSelected;
  }

  @override
  set noteSelected(int? value) {
    _$noteSelectedAtom.reportWrite(value, super.noteSelected, () {
      super.noteSelected = value;
    });
  }

  late final _$_NotesStoreActionController =
      ActionController(name: '_NotesStore', context: context);

  @override
  void updateNotes(String note) {
    final _$actionInfo = _$_NotesStoreActionController.startAction(
        name: '_NotesStore.updateNotes');
    try {
      return super.updateNotes(note);
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeNote(int index) {
    final _$actionInfo = _$_NotesStoreActionController.startAction(
        name: '_NotesStore.removeNote');
    try {
      return super.removeNote(index);
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fetchNotesList() {
    final _$actionInfo = _$_NotesStoreActionController.startAction(
        name: '_NotesStore.fetchNotesList');
    try {
      return super.fetchNotesList();
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notes: ${notes},
error: ${error},
noteSelected: ${noteSelected}
    ''';
  }
}
