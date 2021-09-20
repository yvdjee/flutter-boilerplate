import 'dart:convert';
import 'dart:developer';
import 'package:domodar/constant/api_paths.dart';
import 'package:domodar/models/request_error.dart';
import 'package:http/http.dart';

bool isSuccessful(int status) {
  return status >= 200 && status <= 300;
}

Future<Response> postRequest(String endPoint, Map<String, dynamic> body) async {
  log("$BASE_URL$endPoint");
  var response = await post(
    Uri.parse('$BASE_URL$endPoint'),
    body: body,
    headers: HEADERS,
  );
  return response;
}

Future<Response> getRequest(String endPoint) async {
  log("$BASE_URL$endPoint");
  var response = await get(
    Uri.parse('$BASE_URL$endPoint'),
    headers: HEADERS,
  );
  return response;
}

Future resolveResponse(Response response) async {
  if (isSuccessful(response.statusCode)) {
    return jsonDecode(response.body);
  } else {
    print(response.body);
    throw RequestError.fromJson(jsonDecode(response.body));
  }
}

Future resolveStatusCode(Response response) async {
  return response.statusCode;
}
