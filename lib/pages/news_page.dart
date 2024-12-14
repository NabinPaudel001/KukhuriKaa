import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<dynamic>> newsData;

  // Function to load the JSON file from assets
  Future<List<dynamic>> loadJsonData() async {
    final String jsonString = await rootBundle.loadString('assets/data.json');
    final List<dynamic> jsonData = jsonDecode(jsonString);

    // Filter the data (e.g., only include items where 'prediction' is 1)
    return jsonData.where((item) => item['prediction'] == 1).toList();
  }

  @override
  void initState() {
    super.initState();
    newsData = loadJsonData(); // Load JSON data when the widget is initialized
  }

  // Function to launch a URL in a browser
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: newsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text('No news to display.'));
        }

        final news = snapshot.data!;
        return ListView.builder(
          itemCount: news.length,
          itemBuilder: (context, index) {
            final item = news[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                title: Text(item['title']),
                subtitle: Text(item['source'] ?? 'No source available'),
                onTap: () => _launchURL(item['url']), // Open URL on tap
              ),
            );
          },
        );
      },
    );
  }
}
