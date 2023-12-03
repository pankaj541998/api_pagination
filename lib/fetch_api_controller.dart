import 'dart:convert';

import 'package:http/http.dart' as http;

class FetchApi {
  Future<void> fetchApi() async {
    const url = 'https://api.slingacademy.com/v1/sample-data/users?limit=20';

    var response = await http.get(Uri.parse(url));

    print('response.body ${response.body}');

    if (response.statusCode == 200) {
      final  data = jsonDecode(response.body)["users"] as List;

    } else {
    }
  }
}
