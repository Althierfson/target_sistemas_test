import 'dart:io';

String readJsonFromName(String name) =>
    File("test/json/$name").readAsStringSync();
