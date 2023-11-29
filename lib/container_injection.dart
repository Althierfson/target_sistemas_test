import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_sistemas_test/data/datasources/login/login_data_source_local.dart';
import 'package:target_sistemas_test/data/datasources/login/login_data_source_local_impl.dart';
import 'package:target_sistemas_test/data/datasources/login/login_data_source_remote.dart';
import 'package:target_sistemas_test/data/datasources/login/login_data_source_remote_impl.dart';
import 'package:target_sistemas_test/data/datasources/notes/notes_data_source_local.dart';
import 'package:target_sistemas_test/data/datasources/notes/notes_data_source_local_impl.dart';
import 'package:target_sistemas_test/data/repositories/login/login_repository.dart';
import 'package:target_sistemas_test/data/repositories/notes/notes_repository_impl.dart';
import 'package:target_sistemas_test/domain/repositories/login/login_repository.dart';
import 'package:target_sistemas_test/domain/repositories/notes/notes_repository.dart';
import 'package:target_sistemas_test/domain/usecases/login/login_with_user_name_password.dart';
import 'package:target_sistemas_test/domain/usecases/notes/fetch_notes.dart';
import 'package:target_sistemas_test/domain/usecases/notes/save_notes.dart';
import 'package:target_sistemas_test/presentation/mobx/login/login_store.dart';
import 'package:target_sistemas_test/presentation/mobx/notes/notes_store.dart';
import 'package:target_sistemas_test/route_generato.dart';

GetIt it = GetIt.instance;

Future<void> setupContainer() async {
  // External
  it.registerLazySingleton<http.Client>(() => http.Client());
  final sharedPreference = await SharedPreferences.getInstance();
  it.registerLazySingleton<SharedPreferences>(() => sharedPreference);

  // Internal
  it.registerLazySingleton(() => RouteGenerato());

  // features
  loginFeature();
  notesFeature();
}

void loginFeature() {
  it.registerLazySingleton<LoginDataSourceLocal>(
      () => LoginDataSourceLocalImpl(shared: it()));
  it.registerLazySingleton<LoginDataSourceRemote>(
      () => LoginDataSourceRemoteImpl(client: it()));

  it.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
      loginDataSourceRemote: it(), loginDataSourceLocal: it()));

  it.registerLazySingleton(
      () => LoginWithUserNameAndPassword(repository: it()));

  it.registerFactory(() => LoginStore(loginWithUserNameAndPassword: it()));
}

void notesFeature() {
  it.registerLazySingleton<NotesDataSourceLocal>(
      () => NotesDataSourceLocalImpl(shared: it()));

  it.registerLazySingleton<NotesRepository>(
      () => NotesRepositoryImpl(dataSourceLocal: it()));

  it.registerLazySingleton(() => SaveNotes(repository: it()));
  it.registerLazySingleton(() => FetchNotes(repository: it()));

  it.registerFactory(() => NotesStore(saveNotes: it(), fetchNotes: it()));
}
