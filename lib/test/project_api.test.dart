import 'package:fym_test_1/Projects/project_api.dart';
import 'package:fym_test_1/Projects/shared_Api_infra/http_client_contract.dart';
// import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class HttpClient extends Mock implements IHttpClient {}

void main() {
  ProjectApi sut;
  HttpClient client;
  setUp(() {
    client = HttpClient();
    sut = ProjectApi(client, 'baseUrl');
  });

  group('getAllProjects', () {
    test('returns an empty list when no projects are found', () {});
  });
}
