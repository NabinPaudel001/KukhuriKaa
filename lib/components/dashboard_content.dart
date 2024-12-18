import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kukhurikaa/components/circular_progress.dart';
import 'package:kukhurikaa/providers/control_provider.dart';
import 'package:provider/provider.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  List<Map<String, String>> alerts = [];
  String? alertTitle;
  String? alertMessage;
  bool isTemperatureControlOn = false;
  bool isHumidityControlOn = false;
  double temperature = 0.0;
  double humidity = 0.0;
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref('test'); // Reference to "test" node
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start a timer to fetch data every 1 second
    _timer = Timer.periodic(Duration(seconds: 1), _fetchData);
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _fetchData(Timer timer) async {
    try {
      // Fetch the data from Firebase Realtime Database
      DataSnapshot snapshot = await _databaseReference.get();
      if (snapshot.exists) {
        var data = snapshot.value as Map;
        setState(() {
          // Update the state with the new values
          temperature = (data['temp'] is int
                  ? (data['temp'] as int).toDouble()
                  : data['temp']) ??
              0.0;
          humidity = (data['humidity'] is int
                  ? (data['humidity'] as int).toDouble()
                  : data['humidity']) ??
              0.0;

          // Handle the alerts based on the temperature and humidity
          checkAlerts(temperature, humidity);
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  double updateProgress(double value) {
    // Limit to 2 decimal places
    return double.parse(value.toStringAsFixed(2));
  }

  void checkAlerts(double temperature, double humidity) {
    // Clear previous alerts
    alerts.clear();

    if (temperature < 30) {
      alerts.add({
        'title': 'Temperature too low',
        'message': 'Light turned on.',
      });
    } else if (temperature > 33) {
      alerts.add({
        'title': 'Temperature too high',
        'message': 'Fan turned on.',
      });
    }

    if (humidity < 60) {
      alerts.add({
        'title': 'Humidity too low',
        'message': 'Cooling fan turned on.',
      });
    } else if (humidity > 70) {
      alerts.add({
        'title': 'Humidity too high',
        'message': 'LED bulb turned on.',
      });
    }
  }

  void showAlert(String title, String message) {
    // Show the alert with the appropriate title and message
    setState(() {
      alertTitle = title;
      alertMessage = message;
    });
  }

  void removeAlert() {
    // Remove the alert message when the values are within the normal range
    setState(() {
      alertTitle = null;
      alertMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controlProvider = Provider.of<ControlProvider>(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularProgress(
                  title: "Temperature",
                  progress: temperature,
                  unit: '°C',
                  foregroundColor: Colors.red,
                ),
                SizedBox(
                  width: 20,
                ),
                CircularProgress(
                  title: "Humidity",
                  progress: humidity,
                  unit: '%',
                  foregroundColor: Colors.blue,
                ),
              ],
            ),

            // Example list of items (can be a list of recent alerts, logs, etc.)
            // ListTile(
            //   leading: Icon(Icons.warning, color: Colors.red),
            //   title: Text('Alert: High Temperature'),
            //   subtitle: Text('The temperature has exceeded the safe limit!'),
            // ),
            // ListView.builder to display multiple alerts
            if (alerts.isNotEmpty)
              ListView.builder(
                shrinkWrap: true, // To avoid overflow issues
                physics: NeverScrollableScrollPhysics(), // Disable scrolling
                itemCount: alerts.length,
                itemBuilder: (context, index) {
                  final alert = alerts[index];
                  return ListTile(
                    leading: Icon(Icons.warning, color: Colors.red),
                    title: Text(alert['title']!),
                    subtitle: Text(alert['message']!),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
