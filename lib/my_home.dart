// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final scrollController = ScrollController();
  List userList = [];
  var data = 10;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListner);
    fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call the api with paginations'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              shrinkWrap: true,
              itemCount: loading ?userList.length + 1 :userList.length,
              itemBuilder: (context, index) {

                if(index < userList.length){
                print('userList  $userList');
                var data = userList[index];
                  return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      child: Image.network(
                        data["profile_picture"],
                      ),
                    ),
                  ),
                  title:
                      Text('${data["first_name"] + ' ' + data["last_name"]}'),
                      subtitle:Text(data["email"])
                );
                }else{
                  return Center( child: CircularProgressIndicator(),);
                }

                
              },
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Future<void> fetchApi() async {
    final url = 'https://api.slingacademy.com/v1/sample-data/users?limit=$data';

    var response = await http.get(Uri.parse(url));

    // print('response.body ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)["users"] as List;
      setState(() {
        userList = data;
      });
    } else {
      print('Something wet wrong');
    }
  }

  Future<void> _scrollListner() async{

    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(loading) return;
      setState(() {
        loading = true;
      });
      await fetchApi();
      data = data +10;
      setState(() {
        loading = false;
      });
      print('Call the api');
    }else{
      print('Don\'t call the api');
    }
    // print('scrollListner ${scrollController.position.pixels == scrollController.position.maxScrollExtent}');
  }
}
