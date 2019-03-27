import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = 'https://warm-ocean-42352.herokuapp.com';

class API {
  static Future getNotes() {
    var url = baseUrl + "/notes";
    return http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"}
    );
  }
}