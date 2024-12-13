import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Generate cards manually in a Column
          for (int i = 0; i < 10; i++)
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text('News Title $i'),
                subtitle: Text('https://newslink.com/item-$i'),
              ),
            ),
        ],
      ),
    );
  }
}
