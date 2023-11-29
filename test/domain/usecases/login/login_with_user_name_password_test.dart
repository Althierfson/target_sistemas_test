import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/core/login/login_success.dart';
import 'package:target_sistemas_test/domain/repositories/login/login_repository.dart';
import 'package:target_sistemas_test/domain/usecases/login/login_with_user_name_password.dart';

import 'login_with_user_name_password_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginRepository>()])
void main() {
  late MockLoginRepository repository;
  late LoginWithUserNameAndPassword usecase;

  setUp(() {
    repository = MockLoginRepository();
    usecase = LoginWithUserNameAndPassword(repository: repository);
  });

  group("input format tests", () {
    group("userName format", () {
      test(
          "Must return a [CredentialStandardsFailure] on Left Side when the userName is empty",
          () async {
        final result = await usecase(userName: "", password: "password");

        verifyNever(repository.loginWithUserNameAndPassword(
            userName: "", password: "password"));

        expect(
            result,
            Left(CredentialStandardsFailure(
                userNameErrors: const ["Esse campo não pode ser vaziu."])));
      });

      test(
          "Must return a [CredentialStandardsFailure] on Left Side when the userName has space at the end",
          () async {
        final result =
            await usecase(userName: "username ", password: "password");

        verifyNever(repository.loginWithUserNameAndPassword(
            userName: "username ", password: "password"));

        expect(
            result,
            Left(CredentialStandardsFailure(userNameErrors: const [
              "Não pode haver espaço em branco no final."
            ])));
      });

      test(
          "Must return a [CredentialStandardsFailure] on Left Side when the userName has more the 20 characters",
          () async {
        final result = await usecase(
            userName: "usernameusernameusername", password: "password");

        verifyNever(repository.loginWithUserNameAndPassword(
            userName: "usernameusernameusername", password: "password"));

        expect(
            result,
            Left(CredentialStandardsFailure(userNameErrors: const [
              "Não pode haver mais de 20 caracteres."
            ])));
      });
    });

    group("password format", () {
      test(
          "Must return a [CredentialStandardsFailure] on Left Side when the password is empty",
          () async {
        final result = await usecase(userName: "userName", password: "");

        verifyNever(repository.loginWithUserNameAndPassword(
            userName: "userName", password: ""));

        expect(
            result,
            Left(CredentialStandardsFailure(
                passwordErrors: const ["Esse campo não pode ser vaziu."])));
      });

      test(
          "Must return a [CredentialStandardsFailure] on Left Side when the password has space at the end",
          () async {
        final result =
            await usecase(userName: "username", password: "password ");

        verifyNever(repository.loginWithUserNameAndPassword(
            userName: "username", password: "password "));

        expect(
            result,
            Left(CredentialStandardsFailure(passwordErrors: const [
              "Não pode haver espaço em branco no final."
            ])));
      });

      test(
          "Must return a [CredentialStandardsFailure] on Left Side when the userName has more the 20 characters",
          () async {
        final result = await usecase(
            userName: "username", password: "passwordpasswordpassword");

        verifyNever(repository.loginWithUserNameAndPassword(
            userName: "username", password: "passwordpasswordpassword"));

        expect(
            result,
            Left(CredentialStandardsFailure(passwordErrors: const [
              "Não pode haver mais de 20 caracteres."
            ])));
      });

      test(
          "Must return a [CredentialStandardFailure] on Left Side when the password is less than two characters long",
          () async {
        final result = await usecase(userName: "username", password: "p");

        verifyNever(repository.loginWithUserNameAndPassword(
            userName: "any", password: "p"));

        expect(
            result,
            Left(CredentialStandardsFailure(passwordErrors: const [
              "Senha não pode ter menor que 2 caracteres."
            ])));
      });

      test(
          "Must return a [CredentialStandardFailure] on Left Side when the password contains special characters",
          () async {
        final result =
            await usecase(userName: "username", password: "password@123");

        verifyNever(repository.loginWithUserNameAndPassword(
            userName: "username", password: "password@123"));

        expect(
            result,
            Left(CredentialStandardsFailure(passwordErrors: const [
              "Senha não pode ter caracteres especiais."
            ])));
      });
    });
  });

  group("Repository Test", () {
    test(
        "Should return a LoginSuccess on the right side when the repository returns a LoginSuccess",
        () async {
      when(repository.loginWithUserNameAndPassword(
              userName: "userName", password: "password"))
          .thenAnswer((_) async => Right(LoginSuccess()));

      final result = await usecase(userName: "userName", password: "password");

      expect(result, Right(LoginSuccess()));
    });

    test(
        "It should return a Failure on the left side when the repository returns a Failure",
        () async {
      when(repository.loginWithUserNameAndPassword(
              userName: "userName", password: "password"))
          .thenAnswer((_) async => Left(LoginFailure()));

      final result = await usecase(userName: "userName", password: "password");

      expect(result, Left(LoginFailure()));
    });
  });
}
