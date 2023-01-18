import 'dart:convert';
import 'package:http/http.dart' as http;

class HTTP {
  static String urlLink  = "192.168.1.8";
  static Map<String, String> headers = <String, String>{
    'Content-Type': 'application/json',
  };

  static Future<Map> get(String url) async {
    http.Response response = await http
        .get(Uri.parse(url), headers: headers)
        .timeout(const Duration(seconds: 5));
    updateCookie(response);
    var x = json.decode(response.body);

    return x;
  }

  static Future<Map> post(String url, dynamic data) async {
    http.Response response = await http
        .post(Uri.parse(url), body: data, headers: headers)
        .timeout(const Duration(seconds: 5));
    updateCookie(response);
    var x = json.decode(response.body);

    return x;
  }

  static Future<Map> delete(String url, dynamic body) async {
    http.Response response = await http
        .delete(Uri.parse(url), headers: headers, body: body)
        .timeout(const Duration(seconds: 5));
    updateCookie(response);
    var x = json.decode(response.body);

    return x;
  }

  static void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['Cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
