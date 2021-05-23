import 'dart:async';
import 'dart:io';

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
    try {
      return await client
          .get(url, headers: modifiedHeader)
          .timeout(Duration(seconds: 12));
    } on TimeoutException catch (e) {
      return HttpResult(e.toString(), Status.failure);
      // throw Exception(e.message);
    } on SocketException catch (e) {
      return HttpResult(e.toString(), Status.failure);
    }
  }

  @override
  Future<HttpResult> delete(String url, {Map<String, String> headers}) async {
    print("secure client delte method called");
    print(url);

    final token = await store.fetch();
    print("Token fetched from phone is ::" + token.value);

    final modifiedHeader = headers ?? {};
    modifiedHeader['Content-Type'] = 'application/json';
    modifiedHeader['Authorization'] = token.value;

    print(modifiedHeader);
    try {
      return await client.delete(url, headers: modifiedHeader);
    } on TimeoutException catch (e) {
      return HttpResult(e.toString(), Status.failure);
      // throw Exception(e.message);
    } on SocketException catch (e) {
      return HttpResult(e.toString(), Status.failure);
    }
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
    try {
      return await client.post(url, body, headers: modifiedHeader);
    } on TimeoutException catch (e) {
      return HttpResult(e.toString(), Status.failure);
      // throw Exception(e.message);
    } on SocketException catch (e) {
      return HttpResult(e.toString(), Status.failure);
    }
  }

  @override
  Future<HttpResult> put(String url, String body,
      {Map<String, String> headers}) async {
    print("Put method caleed for posting projectedit  details");
    print("Url received inside post method of secure client   ::" + url);
    print("Body received inside post method of secure client   ::" + body);
    final token = await store.fetch();
    final modifiedHeader = headers ?? {};
    modifiedHeader['Content-Type'] = 'application/json';
    modifiedHeader['Authorization'] = token.value;
    print("Headers Inside post method of secure client :::" +
        modifiedHeader.toString());
    try {
      return await client.put(url, body, headers: modifiedHeader);
    } on TimeoutException catch (e) {
      return HttpResult(e.toString(), Status.failure);
      // throw Exception(e.message);
    } on SocketException catch (e) {
      return HttpResult(e.toString(), Status.failure);
    }
  }
}
