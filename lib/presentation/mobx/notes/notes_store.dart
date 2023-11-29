import 'package:mobx/mobx.dart';
import 'package:target_sistemas_test/domain/usecases/notes/fetch_notes.dart';
import 'package:target_sistemas_test/domain/usecases/notes/save_notes.dart';

part 'notes_store.g.dart';

class NotesStore = _NotesStore with _$NotesStore;

abstract class _NotesStore with Store {
  final FetchNotes fetchNotes;
  final SaveNotes saveNotes;

  _NotesStore({required this.fetchNotes, required this.saveNotes});

  @observable
  List<String> notes = [];

  @observable
  String? error;

  @observable
  int? noteSelected;

  @action
  void updateNotes(String note) {
    if (note.isEmpty) {
      error = "Não é possivel adicionar um valor vazio.";
    } else {
      List<String> newList = [];
      newList.addAll(notes);
      if (noteSelected == null) {
        newList.add(note);
      } else {
        newList[noteSelected!] = note;
        noteSelected = null;
      }

      saveNotes(newList).then((value) => value.fold(
          (failure) => error = failure.message, (success) => notes = success));
    }
  }

  @action
  void removeNote(int index) {
    List<String> newList = [];
    newList.addAll(notes);
    newList.removeAt(index);
    saveNotes(newList).then((value) => value.fold(
        (failure) => error = failure.message, (success) => notes = success));
  }

  @action
  void fetchNotesList() {
    fetchNotes().then((value) => value.fold(
        (failure) => error = failure.message, (success) => notes = success));
  }
}
