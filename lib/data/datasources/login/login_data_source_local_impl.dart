import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_sistemas_test/core/failures.dart';
import 'package:target_sistemas_test/core/login/login_success.dart';
import 'package:target_sistemas_test/data/datasources/login/login_data_source_local.dart';
import 'package:target_sistemas_test/data/models/user_model.dart';

class LoginDataSourceLocalImpl implements LoginDataSourceLocal {
  final SharedPreferences shared;

  LoginDataSourceLocalImpl({required this.shared});

  final String _loggedinUserKey = "_loggedinUserKey";

  @override
  Future<LoggedinUserSaved> saveLoggedinUser(UserModel userModel) async {
    try {
      await shared.setString(_loggedinUserKey, jsonEncode(userModel.toJson()));
      return LoggedinUserSaved();
    } catch (e) {
      debugPrint(e.toString());
      throw LoginFailure();
    }
  }
}
