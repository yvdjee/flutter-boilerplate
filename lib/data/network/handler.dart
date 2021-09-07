import 'package:domodar/constant/api_paths.dart';

import 'resolver.dart';

class HttpHandler {
  static Future login(String username, String password) async {
    return resolveResponse(
        await postRequest(SIGNIN, {'email': username, 'password': password}));
  }

  static Future resetPassword(String email) async {
    return resolveResponse(await postRequest(RESET_PASSWORD, {'email': email}));
  }
}
