import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketPage extends StatefulWidget {
  const WebSocketPage({super.key});

  @override
  _WebSocketPageState createState() => _WebSocketPageState();
}

class _WebSocketPageState extends State<WebSocketPage> {
  late WebSocketChannel channel;
  String message = "Waiting for data...";
  double humidity = 0.0;
  double temperature = 0.0;

  @override
  void initState() {
    super.initState();

    // Replace with your server WebSocket URL
    channel = WebSocketChannel.connect(Uri.parse(
        'ws://localhost:PORT')); // Replace with your Node.js server's URL

    // Listen for incoming messages from the server
    channel.stream.listen((data) {
      // Handle the data received from the server
      setState(() {
        try {
          var parsedData = Map<String, dynamic>.from(jsonDecode(data));
          if (parsedData.containsKey('humidity') &&
              parsedData.containsKey('temperature')) {
            humidity = parsedData['humidity'];
            temperature = parsedData['temperature'];
            message =
                "Data received: Humidity - $humidity%, Temperature - $temperature°C";
          } else if (parsedData['message'] != null) {
            message = parsedData['message'];
          }
        } catch (e) {
          message = "Error receiving data";
        }
      });
    });
  }

  @override
  void dispose() {
    channel.sink
        .close(); // Close the WebSocket connection when leaving the screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WebSocket Demo")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(message),
            const SizedBox(height: 20),
            Text("Humidity: $humidity%"),
            Text("Temperature: $temperature°C"),
          ],
        ),
      ),
    );
  }
}
