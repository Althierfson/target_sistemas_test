import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/core/login/login_success.dart';
import 'package:target_sistemas_test/data/datasources/login/login_data_source_local.dart';
import 'package:target_sistemas_test/data/datasources/login/login_data_source_remote.dart';
import 'package:target_sistemas_test/data/repositories/login/login_repository.dart';

import '../../../test_values.dart';
import 'login_repository_impl_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<LoginDataSourceRemote>(), MockSpec<LoginDataSourceLocal>()])
void main() {
  late MockLoginDataSourceRemote dataSourceRemote;
  late MockLoginDataSourceLocal dataSourceLocal;
  late LoginRepositoryImpl repository;

  setUp(() {
    dataSourceRemote = MockLoginDataSourceRemote();
    dataSourceLocal = MockLoginDataSourceLocal();
    repository = LoginRepositoryImpl(
        loginDataSourceRemote: dataSourceRemote,
        loginDataSourceLocal: dataSourceLocal);
  });

  group("function loginWithUseNameAndPassword", () {
    test(
        "Should return a LoginSucess when both remote and local return successes",
        () async {
      when(dataSourceRemote.loginWithUserNameAndPassword(
              userName: "userName", password: "password"))
          .thenAnswer((_) async => getUserModel());

      when(dataSourceLocal.saveLoggedinUser(any))
          .thenAnswer((_) async => LoggedinUserSaved());

      final result = await repository.loginWithUserNameAndPassword(
          userName: "userName", password: "password");

      expect(result, Right(LoginSuccess()));
    });

    test("Should return a LoginFailure when the remote fails", () async {
      when(dataSourceRemote.loginWithUserNameAndPassword(
              userName: "userName", password: "password"))
          .thenThrow(LoginFailure());

      final result = await repository.loginWithUserNameAndPassword(
          userName: "userName", password: "password");

      verifyNever(dataSourceLocal.saveLoggedinUser(any));

      expect(result, Left(LoginFailure()));
    });

    test("Should return a LoginFailure when the local fails", () async {
      when(dataSourceRemote.loginWithUserNameAndPassword(
              userName: "userName", password: "password"))
          .thenAnswer((_) async => getUserModel());

      when(dataSourceLocal.saveLoggedinUser(any)).thenThrow(LoginFailure());

      final result = await repository.loginWithUserNameAndPassword(
          userName: "userName", password: "password");

      expect(result, Left(LoginFailure()));
    });

    test("Should return a UnexpectedError when some enexpected error happen",
        () async {
      when(dataSourceRemote.loginWithUserNameAndPassword(
              userName: "userName", password: "password"))
          .thenThrow(Exception());

      final result = await repository.loginWithUserNameAndPassword(
          userName: "userName", password: "password");

      expect(result, Left(UnexpectedError()));
    });
  });
}
