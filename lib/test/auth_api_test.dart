import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:fym_test_1/auth/src/credentail.dart';
import 'package:fym_test_1/infra/api/auth_api.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:async/async.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  MockClient client;
  AuthApi sut;

  setUp(() {
    client = MockClient();
    sut = AuthApi('http:baseUrl', client);
  });

  group('signin', () {
    var credential = Credentail('eamil@email.com', 'pass');
    // test('should return error when status code is not 200', () async {
    //   when(client.post(any, body: anyNamed('body')))
    //       .thenAnswer((_) async => http.Response('{}', 404));

    //   var result = await sut.signIn(credential);
    //   expect(result, isA<ErrorResult>());
    // });

    test('should return error when status code is  200 but malformed json',
        () async {
      when(client.post(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('{}', 200));

      var result = await sut.apisignIn(credential);
      expect(result, isA<ErrorResult>());
    });

    // test('should return token string when success', () async {

    //   var token = "!!22213dfa";
    //   when(client.post(any, body: anyNamed('body'))).thenAnswer(
    //       (_) async => http.Response(jsonEncode({'auth_token': token}), 200));

    //   var result = await sut.signIn(credential);
    //   expect(result.asValue.value, token);
    // }
    // );
  });
}
