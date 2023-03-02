import 'dart:convert';

import 'package:api_call_app/data_screen.dart';
import 'package:api_call_app/model/character_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  CharacterModel? characterModel;

  @override
  void initState() {
    // TODO: implement initState
    getPostAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: characterModel == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: characterModel!.results!.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataScreen(
                        info: characterModel!.info,
                        results: characterModel!.results![index],
                      ),
                    ),
                  );
                },
                tileColor: Colors.green,
                leading: Image.network(characterModel!.results![index].image!),
                title: Text(characterModel!.results![index].name!),
                subtitle: Text(characterModel!.results![index].status!),
                trailing: Text(characterModel!.results![index].gender!),
              ),
            ),
    );
  }

  getPostAPI() async {
    var client = http.Client();
    try {
      Response response = await client.get(Uri.parse("https://rickandmortyapi.com/api/character"));
      if (response.statusCode == 200) {
        characterModel = CharacterModel.fromJson(jsonDecode(response.body));
        debugPrint("characterModal -------------->>> ${characterModel!.toJson()}");
        setState(() {});
      } else {
        debugPrint("Status Code -------------->>> ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }
}
