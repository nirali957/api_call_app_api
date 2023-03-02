import 'dart:convert';

import 'package:api_call_app/model/post_model.dart';
import 'package:api_call_app/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postsList = [];

  @override
  void initState() {
    // TODO: implement initState
    getPostAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("homeScreen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecondScreen(),
              ));
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.navigate_next),
      ),
      body: Column(
        children: [
          Expanded(
            child: postsList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemCount: postsList.length,
                    itemBuilder: (context, index) => ListTile(
                      tileColor: Colors.teal,
                      title: Text(postsList[index].title!),
                      subtitle: Text(postsList[index].body!),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  Colors.red,
                )),
                onPressed: () {
                  setPostsAPI();
                },
                child: const Text('Send')),
          ),
        ],
      ),
    );
  }

  getPostAPI() async {
    var client = http.Client();
    try {
      Response response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (response.statusCode == 200) {
        postsList = (jsonDecode(response.body) as List?)!.map((dynamic e) => PostsModel.fromJson(e)).toList();
        setState(() {});
      } else {
        debugPrint("Status Code -------------->>> ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }

  setPostsAPI() async {
    Client client = http.Client();
    try {
      Response response = await client.post(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userId": 115,
          "id": 89,
          "title": "Nirali",
          "body": "SkillQode",
        }),
      );
      if (response.statusCode == 200) {
        debugPrint("Response -------------->>> ${jsonDecode(response.body)}");
        setState(() {});
      } else if (response.statusCode == 201) {
        debugPrint("Response -------------->>> ${jsonDecode(response.body)}");
        setState(() {});
      } else {
        debugPrint("Status Code -------------->>> ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }
}
