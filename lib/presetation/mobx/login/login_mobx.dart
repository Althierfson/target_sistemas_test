import 'package:mobx/mobx.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/domain/usecases/login/login_with_user_name_password.dart';

part 'login_mobx.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final LoginWithUserNameAndPassword loginWithUserNameAndPassword;

  _LoginStore({required this.loginWithUserNameAndPassword});

  @observable
  String? error;

  @observable
  List<String>? userNameErrors;

  @observable
  List<String>? passwordErrors;

  @observable
  bool goToNextpage = false;

  @observable
  bool isLoading = false;

  @action
  void makeLogin({required String userName, required String password}) {
    isLoading = true;

    loginWithUserNameAndPassword(userName: userName, password: password)
        .then((value) {
      value.fold((failure) {
        if (failure is CredentialStandardsFailure) {
          userNameErrors = failure.userNameErrors;
          passwordErrors = failure.passwordErrors;
        } else {
          userNameErrors = null;
          passwordErrors = null;
          error = failure.message;
        }
      }, (success) => goToNextpage = true);
      isLoading = false;
    });
  }
}
