// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStore, Store {
  late final _$errorAtom = Atom(name: '_LoginStore.error', context: context);

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

  late final _$userNameErrorsAtom =
      Atom(name: '_LoginStore.userNameErrors', context: context);

  @override
  List<String>? get userNameErrors {
    _$userNameErrorsAtom.reportRead();
    return super.userNameErrors;
  }

  @override
  set userNameErrors(List<String>? value) {
    _$userNameErrorsAtom.reportWrite(value, super.userNameErrors, () {
      super.userNameErrors = value;
    });
  }

  late final _$passwordErrorsAtom =
      Atom(name: '_LoginStore.passwordErrors', context: context);

  @override
  List<String>? get passwordErrors {
    _$passwordErrorsAtom.reportRead();
    return super.passwordErrors;
  }

  @override
  set passwordErrors(List<String>? value) {
    _$passwordErrorsAtom.reportWrite(value, super.passwordErrors, () {
      super.passwordErrors = value;
    });
  }

  late final _$goToNextpageAtom =
      Atom(name: '_LoginStore.goToNextpage', context: context);

  @override
  bool get goToNextpage {
    _$goToNextpageAtom.reportRead();
    return super.goToNextpage;
  }

  @override
  set goToNextpage(bool value) {
    _$goToNextpageAtom.reportWrite(value, super.goToNextpage, () {
      super.goToNextpage = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_LoginStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_LoginStoreActionController =
      ActionController(name: '_LoginStore', context: context);

  @override
  void makeLogin({required String userName, required String password}) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.makeLogin');
    try {
      return super.makeLogin(userName: userName, password: password);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
userNameErrors: ${userNameErrors},
passwordErrors: ${passwordErrors},
goToNextpage: ${goToNextpage},
isLoading: ${isLoading}
    ''';
  }
}
