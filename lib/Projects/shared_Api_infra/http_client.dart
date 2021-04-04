import 'package:fym_test_1/Projects/shared_Api_infra/http_client_contract.dart';
import 'package:http/http.dart';

class HttpClientImpl implements IHttpClient {
  final Client _client;

  HttpClientImpl(this._client);

  @override
  Future<HttpResult> get(url, {Map<String, String> headers}) async {
    print("url inside http_client.dart" + url);
    print("Headers inside http_client.dart ::" + headers.toString());
    final response = await _client.get(url, headers: headers);
    print("Response received from secure client :: " + response.body);
    return HttpResult(response.body, _setStatus(response));
  }

  @override
  Future<HttpResult> post(url, String body,
      {Map<String, String> headers}) async {
    final response = await _client.post(url, body: body, headers: headers);
    return HttpResult(response.body, _setStatus(response));
  }

  _setStatus(Response response) {
    if (response.statusCode != 200) return Status.failure;
    return Status.success;
  }
}
