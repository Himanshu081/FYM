import 'package:fym_test_1/auth/src/credentail.dart';
import 'package:fym_test_1/infra/api/auth_api.dart';
import 'package:http/http.dart' as http;

import 'package:async/async.dart';
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

void main() {
  AuthApi sut;
  String baseUrl = "http://192.168.0.4:5000";
  http.Client client;

  setUp(() {
    client = http.Client();
    sut = AuthApi(baseUrl, client);
  });

  group('signin', () {
    var credential = Credentail('lakshay17csu093@ncuindia.edu', '12345678');
    test('should return json toke when success', () async {
      var result = await sut.apisignIn(credential);
      print(result.asValue.value);

      expect(result.asValue.value, isNotEmpty);
    });
  });
}
