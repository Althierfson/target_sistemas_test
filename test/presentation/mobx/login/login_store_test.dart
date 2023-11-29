import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/core/login/login_success.dart';
import 'package:target_sistemas_test/domain/usecases/login/login_with_user_name_password.dart';
import 'package:target_sistemas_test/presentation/mobx/login/login_store.dart';

import 'login_store_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginWithUserNameAndPassword>()])
void main() {
  late MockLoginWithUserNameAndPassword userCase;
  late LoginStore store;

  setUp(() {
    userCase = MockLoginWithUserNameAndPassword();
    store = LoginStore(loginWithUserNameAndPassword: userCase);
  });

  test("goToNextPage should be true when login is successful", () async {
    when(userCase(userName: "userName", password: "password"))
        .thenAnswer((_) async => Right(LoginSuccess()));

    expect(store.isLoading, false);
    expect(store.goToNextpage, false);

    store.makeLogin(userName: "userName", password: "password");

    expect(store.isLoading, true);

    await Future.delayed(const Duration(seconds: 2));

    expect(store.isLoading, false);

    expect(store.goToNextpage, true);
  });

  test(
      "goToNextPage should be false when login is not possible and error should have the error message",
      () async {
    when(userCase(userName: "userName", password: "password"))
        .thenAnswer((_) async => Left(InvalidCredentialsFailure()));

    expect(store.isLoading, false);
    expect(store.goToNextpage, false);

    store.makeLogin(userName: "userName", password: "password");

    expect(store.isLoading, true);

    await Future.delayed(const Duration(seconds: 2));

    expect(store.isLoading, false);

    expect(store.goToNextpage, false);

    expect(store.error, InvalidCredentialsFailure().message);
  });

  test(
      "userNameErrors and passwordErrors should have the errors coming from the usecase",
      () async {
    when(userCase(userName: "userName", password: "password")).thenAnswer(
        (_) async => Left(CredentialStandardsFailure(
            userNameErrors: const ["erro"], passwordErrors: const ["erro"])));

    expect(store.isLoading, false);
    expect(store.goToNextpage, false);

    store.makeLogin(userName: "userName", password: "password");

    expect(store.isLoading, true);

    await Future.delayed(const Duration(seconds: 2));

    expect(store.isLoading, false);

    expect(store.goToNextpage, false);

    expect(store.userNameErrors, ["erro"]);
    expect(store.passwordErrors, ["erro"]);
  });
}
