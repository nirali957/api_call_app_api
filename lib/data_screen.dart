import 'package:api_call_app/model/character_model.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  final Results? results;
  final Info? info;

  const DataScreen({
    Key? key,
    this.results,
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${results!.name}"),
            const SizedBox(height: 16),
            Text('next: ${info!.next}', style: const TextStyle(fontSize: 18)),
            Text('prev: ${info!.prev}', style: const TextStyle(fontSize: 18)),
            Text('pages: ${info!.pages}', style: const TextStyle(fontSize: 18)),
            Text('count: ${info!.count}', style: const TextStyle(fontSize: 18)),
            Text('ID: ${results!.id}', style: const TextStyle(fontSize: 18)),
            Text('location: ${results!.location!.name}', style: const TextStyle(fontSize: 18)),
            Text('origin: ${results!.origin!.name}', style: const TextStyle(fontSize: 18)),
            Text('image: ${results!.image}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
