import 'package:target_sistemas_test/data/models/user_model.dart';

abstract class LoginDataSourceRemote {
  Future<UserModel> loginWithUserNameAndPassword(
      {required String userName, required String password});
}
