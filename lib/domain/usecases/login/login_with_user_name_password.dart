import 'package:dartz/dartz.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/core/login/login_success.dart';
import 'package:target_sistemas_test/domain/repositories/login/login_repository.dart';

class LoginWithUserNameAndPassword {
  final LoginRepository repository;

  LoginWithUserNameAndPassword({required this.repository});

  Future<Either<Failure, LoginSuccess>> call(
      {required String userName, required String password}) async {
    List<String>? userNameError;
    List<String>? passwordError;
//! reformular os testes
    userNameError = _userNameIsOutOfFormat(userName);
    passwordError = _passwordIsOutOfFormat(password);

    if (userNameError == null && passwordError == null) {
      return repository.loginWithUserNameAndPassword(
          userName: userName, password: password);
    } else {
      return Left(CredentialStandardsFailure(
          userNameErrors: userNameError, passwordErrors: passwordError));
    }
  }

  List<String>? _userNameIsOutOfFormat(String content) {
    List<String> userName = [];

    if (content.isEmpty) {
      userName.add("Esse campo não pode ser vaziu.");
    } else {
      if (_hasMoreThanTwentyCharacters(content)) {
        userName.add("Não pode haver mais de 20 caracteres.");
      }
      if (_thereIsSpaceAtTheEnd(content)) {
        userName.add("Não pode haver espaço em branco no final.");
      }
    }

    return userName.isNotEmpty ? userName : null;
  }

  List<String>? _passwordIsOutOfFormat(String content) {
    List<String> password = [];

    if (content.isEmpty) {
      password.add("Esse campo não pode ser vaziu.");
    } else {
      if (_hasMoreThanTwentyCharacters(content)) {
        password.add("Não pode haver mais de 20 caracteres.");
      }
      if (_thereIsSpaceAtTheEnd(content)) {
        password.add("Não pode haver espaço em branco no final.");
      }
      if (_passwordIsLessThanTwoCharacters(content)) {
        password.add("Senha não pode ter menor que 2 caracteres.");
      }
      if (_containsSpecialCharacters(content)) {
        password.add("Senha não pode ter caracteres especiais.");
      }
    }

    return password.isNotEmpty ? password : null;
  }

  bool _hasMoreThanTwentyCharacters(String content) {
    return content.length > 20;
  }

  bool _thereIsSpaceAtTheEnd(String content) {
    return content[content.length - 1] == " ";
  }

  bool _passwordIsLessThanTwoCharacters(String content) {
    return content.length < 2;
  }

  bool _containsSpecialCharacters(String content) {
    RegExp padrao = RegExp(r'[^\w\s]');
    return padrao.hasMatch(content);
  }
}
