// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/controller.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final fetchapiController = Get.put(FetchApiController());
  @override
  void initState() {
    super.initState();
    fetchapiController.scrollController
        .addListener(fetchapiController.scrollListner);
    fetchapiController.fetchApi();
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
            child: Obx(
              () => ListView.builder(
                physics: BouncingScrollPhysics(),
                controller: fetchapiController.scrollController,
                shrinkWrap: true,
                itemCount: fetchapiController.loading.value
                    ? fetchapiController.userList.length + 1
                    : fetchapiController.userList.length,
                itemBuilder: (context, index) {
                  if (index < fetchapiController.userList.length) {
                    var data = fetchapiController.userList[index];
                    return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(
                            child: Image.network(
                              data["profile_picture"],
                            ),
                          ),
                        ),
                        title: Text(
                            '${data["first_name"] + ' ${index+1} ' + data["last_name"]}'),
                        subtitle: Text(data["email"]));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
