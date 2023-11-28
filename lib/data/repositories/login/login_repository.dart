import 'package:dartz/dartz.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/core/login/login_success.dart';
import 'package:target_sistemas_test/data/datasources/login/login_data_source_local.dart';
import 'package:target_sistemas_test/data/datasources/login/login_data_source_remote.dart';
import 'package:target_sistemas_test/domain/repositories/login/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDataSourceRemote loginDataSourceRemote;
  final LoginDataSourceLocal loginDataSourceLocal;

  LoginRepositoryImpl(
      {required this.loginDataSourceRemote,
      required this.loginDataSourceLocal});

  @override
  Future<Either<Failure, LoginSuccess>> loginWithUserNameAndPassword(
      {required String userName, required String password}) async {
    try {
      final userModel = await loginDataSourceRemote
          .loginWithUserNameAndPassword(userName: userName, password: password);

      await loginDataSourceLocal.saveLoggedinUser(userModel);

      return Right(LoginSuccess());
    } on Failure catch (failure) {
      return Left(failure);
    } catch (error) {
      return Left(UnexpectedError());
    }
  }
}
