import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get message;

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];
}

class UnexpectedError extends Failure {
  @override
  String get message => "Error inesperado! Tente mais tarde.";
}

class LoginFailure extends Failure {
  @override
  String get message => "Não foi possivel realizar o login! Tente mais tarde.";
}

class InvalidCredentialsFailure extends Failure {
  @override
  String get message => "Usuário ou Senha errada.";
}

class CredentialStandardsFailure extends Failure {
  final List<String>? userNameErrors;
  final List<String>? passwordErrors;

  CredentialStandardsFailure({
    this.userNameErrors,
    this.passwordErrors,
  });

  @override
  String get message => "Credenciais não estão no padrão correto.";

  @override
  List<Object?> get props => [userNameErrors, passwordErrors];
}

class SaveNoteFailure extends Failure {
  @override
  String get message => "Não foi possivel savar os dados.";
}

class FetchNoteFailure extends Failure {
  @override
  String get message => "Não foi possivel carregar os dados.";
}
