import 'package:fym_test_1/Projects/shared_Api_infra/http_client_contract.dart';
import 'package:fym_test_1/cache/local_store_contract.dart';

class SecureClient implements IHttpClient {
  final IHttpClient client;
  final ILocalStore store;
  SecureClient(this.client, this.store);

  @override
  Future<HttpResult> get(String url, {Map<String, String> headers}) async {
    print("secure client get method called");

    final token = await store.fetch();
    print("Token fetched from phone is ::" + token.toString());

    final modifiedHeader = headers ?? {};
    modifiedHeader['Content-Type'] = 'application/json';
    modifiedHeader['Authorization'] = token.value;

    print(modifiedHeader);
    return await client.get(url, headers: modifiedHeader);
  }

  @override
  Future<HttpResult> post(String url, String body,
      {Map<String, String> headers}) async {
    final token = await store.fetch();
    final modifiedHeader = headers ?? {};
    modifiedHeader['Authorization'] = token.value;
    return await client.post(url, body, headers: modifiedHeader);
  }
}
