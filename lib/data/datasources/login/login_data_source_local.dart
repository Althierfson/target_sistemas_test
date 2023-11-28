import 'package:target_sistemas_test/core/login/login_success.dart';
import 'package:target_sistemas_test/data/models/user_model.dart';

abstract class LoginDataSourceLocal {
  Future<LoggedinUserSaved> saveLoggedinUser(UserModel userModel);
}
