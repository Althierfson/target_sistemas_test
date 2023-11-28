import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/data/datasources/login/login_data_source_remote_impl.dart';
import 'package:target_sistemas_test/environment.dart';

import '../../../json/read_json.dart';
import '../../../test_values.dart';
import 'login_data_source_remote_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late MockClient mockClient;
  late LoginDataSourceRemoteImpl dataSource;

  setUp(() {
    mockClient = MockClient();
    dataSource = LoginDataSourceRemoteImpl(client: mockClient);
  });

  group("Function loginWithUserNameAndPassWord", () {
    test("Should return a [UserModel] if the auth API returns statusCode 200",
        () async {
      when(mockClient.post(Uri.parse("${Environment.baseUrl}/auth/login"),
              headers: {'Content-Type': 'application/json'},
              body:
                  jsonEncode({"username": "userName", "password": "password"})))
          .thenAnswer((_) async => http.Response.bytes(
              utf8.encode(readJsonFromName("auth_response.json")), 200));

      final result = await dataSource.loginWithUserNameAndPassword(
          userName: "userName", password: "password");

      expect(result, getUserModel());
    });

    test(
        "Should throw a [InvalidCredentialsFailure] the auth API returns statusCode 400",
        () async {
      when(mockClient.post(Uri.parse("${Environment.baseUrl}/auth/login"),
              headers: {'Content-Type': 'application/json'},
              body:
                  jsonEncode({"username": "userName", "password": "password"})))
          .thenAnswer((_) async => http.Response.bytes(
              utf8.encode(readJsonFromName("auth_failure.json")), 400));

      expect(
          () => dataSource.loginWithUserNameAndPassword(
              userName: "userName", password: "password"),
          throwsA(isA<InvalidCredentialsFailure>()));
    });

    test(
        "Should throw a [LoginFailure] if auth API returns statusCode different than 200 or 400",
        () async {
      when(mockClient.post(Uri.parse("${Environment.baseUrl}/auth/login"),
              headers: {'Content-Type': 'application/json'},
              body:
                  jsonEncode({"username": "userName", "password": "password"})))
          .thenAnswer((_) async => http.Response.bytes(
              utf8.encode(readJsonFromName("auth_response.json")), 500));

      expect(
          () => dataSource.loginWithUserNameAndPassword(
              userName: "userName", password: "password"),
          throwsA(isA<LoginFailure>()));
    });

    test("Should throw a [LoginFailure] if the client throws any exception",
        () async {
      when(mockClient.post(Uri.parse("${Environment.baseUrl}/auth/login"),
              headers: {'Content-Type': 'application/json'},
              body:
                  jsonEncode({"username": "userName", "password": "password"})))
          .thenThrow(const SocketException("message"));

      expect(
          () => dataSource.loginWithUserNameAndPassword(
              userName: "userName", password: "password"),
          throwsA(isA<LoginFailure>()));
    });
  });
}
