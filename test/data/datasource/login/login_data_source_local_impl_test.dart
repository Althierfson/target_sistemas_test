import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/core/login/login_success.dart';
import 'package:target_sistemas_test/data/datasources/login/login_data_source_local_impl.dart';

import '../../../test_values.dart';
import 'login_data_source_local_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late MockSharedPreferences shared;
  late LoginDataSourceLocalImpl dataSource;

  setUp(() {
    shared = MockSharedPreferences();
    dataSource = LoginDataSourceLocalImpl(shared: shared);
  });

  group("Function saveLoggedinUser", () {
    test("Should return [LoggedinUserSaved] when [UserModel] is saved",
        () async {
      final userModelTest = getUserModel();
      when(shared.setString(
              "_loggedinUserKey", jsonEncode(userModelTest.toJson())))
          .thenAnswer((_) async => true);

      final result = await dataSource.saveLoggedinUser(userModelTest);

      expect(result, LoggedinUserSaved());
    });

    test("Should throw [LoginFailure] when [UserModel] is not saved", () async {
      final userModelTest = getUserModel();
      when(shared.setString(
              "_loggedinUserKey", jsonEncode(userModelTest.toJson())))
          .thenThrow(Exception());

      expect(() => dataSource.saveLoggedinUser(userModelTest),
          throwsA(isA<LoginFailure>()));
    });
  });
}
