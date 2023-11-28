import 'package:dartz/dartz.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/core/login/login_success.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginSuccess>> loginWithUserNameAndPassword(
      {required String userName, required String password});
}
