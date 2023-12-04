import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FetchApiController extends GetxController {
  final scrollController = ScrollController();
  RxList userList = [].obs;
  var data = 10;
  var offsetData = 0;
  RxBool loading = false.obs;

  Future<void> fetchApi() async {
    final url = 'https://api.slingacademy.com/v1/sample-data/users?offset=$offsetData&&limit=$data';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)["users"] as List;
      userList.value = userList.value + data;
    } else {
      print('Something wet wrong');
    }
  }

  Future<void> scrollListner() async {
    if (loading.value) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loading.value = true;
      await fetchApi();
      offsetData = offsetData + 10;
      // data = data + 10;
      loading.value = false;
    }
  }
}
