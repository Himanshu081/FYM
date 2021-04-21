import 'package:fym_test_1/Projects/shared_Api_infra/http_client_contract.dart';
import 'package:fym_test_1/cache/local_store_contract.dart';

class SecureClient implements IHttpClient {
  final IHttpClient client;
  final ILocalStore store;
  SecureClient(this.client, this.store);

  @override
  Future<HttpResult> get(String url, {Map<String, String> headers}) async {
    // print("secure client get method called");

    final token = await store.fetch();
    print("Token fetched from phone is ::" + token.toString());

    final modifiedHeader = headers ?? {};
    modifiedHeader['Content-Type'] = 'application/json';
    modifiedHeader['Authorization'] = token.value;

    print(modifiedHeader);
    return await client.get(url, headers: modifiedHeader);
  }

  @override
  Future<HttpResult> delete(String url, {Map<String, String> headers}) async {
    // print("secure client get method called");

    final token = await store.fetch();
    print("Token fetched from phone is ::" + token.toString());

    final modifiedHeader = headers ?? {};
    modifiedHeader['Content-Type'] = 'application/json';
    modifiedHeader['Authorization'] = token.value;

    print(modifiedHeader);
    return await client.delete(url, headers: modifiedHeader);
  }

  @override
  Future<HttpResult> post(String url, String body,
      {Map<String, String> headers}) async {
    print("Post method caleed for posting project details");
    print("Url received inside post method of secure client   ::" + url);
    print("Body received inside post method of secure client   ::" + body);
    final token = await store.fetch();
    final modifiedHeader = headers ?? {};
    modifiedHeader['Content-Type'] = 'application/json';
    modifiedHeader['Authorization'] = token.value;
    print("Headers Inside post method of secure client :::" +
        modifiedHeader.toString());
    return await client.post(url, body, headers: modifiedHeader);
  }

  @override
  Future<HttpResult> put(String url, String body,
      {Map<String, String> headers}) async {
    print("Put method caleed for posting project details");
    print("Url received inside post method of secure client   ::" + url);
    print("Body received inside post method of secure client   ::" + body);
    final token = await store.fetch();
    final modifiedHeader = headers ?? {};
    modifiedHeader['Content-Type'] = 'application/json';
    modifiedHeader['Authorization'] = token.value;
    print("Headers Inside post method of secure client :::" +
        modifiedHeader.toString());
    return await client.put(url, body, headers: modifiedHeader);
  }
}
