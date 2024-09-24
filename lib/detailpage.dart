// details_page.dart
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String summary;

  const DetailsPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                summary,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
