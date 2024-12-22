import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Map<String, dynamic>> newsData = [];

  @override
  void initState() {
    super.initState();
    loadNewsData();
  }

  // Load the JSON data from the file
  Future<void> loadNewsData() async {
    final String jsonString =
        await rootBundle.loadString('model/news_predictions.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    // Filter news where prediction == 1
    setState(() {
      newsData = jsonData
          .where((item) => item['prediction'] == 1)
          .map((item) => {
                "title": item['title'],
                "url": item['url'],
              })
          .toList();
    });
  }

  // Open URL in the browser
  void openUrl(String url) async {
    final Uri uri = Uri.parse(url); // Convert the URL string to a Uri object

    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        // If launchUrl fails, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open the link: $url')),
        );
      }
    } catch (e) {
      // Handle any errors
      debugPrint('Error launching URL: $url, Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return newsData.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: newsData.length,
            itemBuilder: (context, index) {
              final newsItem = newsData[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(newsItem['title']),
                  trailing: Icon(Icons.open_in_new),
                  onTap: () => openUrl(newsItem['url']),
                ),
              );
            },
          );
  }
}
