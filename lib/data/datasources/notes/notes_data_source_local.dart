abstract class NotesDataSourceLocal {
  Future<List<String>> saveNotes(List<String> notes);
  Future<List<String>> fetchNotes();
}
