import 'dart:convert';

import 'package:api_call_app/model/comments_model.dart';
import 'package:api_call_app/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<CommentModel> commentList = [];

  @override
  void initState() {
    // TODO: implement initState
    getCommentAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ThirdScreen(),
              ));
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.navigate_next),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      tileColor: Colors.grey,
                      title: Text(commentList[index].email!),
                      subtitle: Text(commentList[index].body!),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                itemCount: commentList.length),
          ),
          ElevatedButton(
            onPressed: () {
              putCommentAPI();
            },
            child: const Text('Put data'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteCommentAPI();
            },
            child: const Text('delete data'),
          ),
        ],
      ),
    );
  }

  getCommentAPI() async {
    var client = http.Client();
    try {
      Response response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments'));
      if (response.statusCode == 200) {
        commentList = (jsonDecode(response.body) as List?)!.map((dynamic e) => CommentModel.fromJson(e)).toList();
        setState(() {});
      } else {
        debugPrint("Status Code ----------------------${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }

  putCommentAPI() async {
    Client client = http.Client();
    try {
      Response response = await client.put(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/1/comments"),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userId": 11,
          "id": 101,
          "title": "Nirali",
          "body": "SkillQode",
        }),
      );
      debugPrint("Status Code -------------->>> ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("Response -------------->>> ${jsonDecode(response.body)}");
        setState(() {});
      } else {
        debugPrint("Status Code -------------->>> ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }

  deleteCommentAPI() async {
    Client client = http.Client();
    try {
      Response response = await client.delete(Uri.parse("https://jsonplaceholder.typicode.com/posts/1/comments/1"));
      debugPrint("Status Code -------------->>> ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("Response -------------->>> ${jsonDecode(response.body)}");
      } else {
        debugPrint("Status Code -------------->>> ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }
}
