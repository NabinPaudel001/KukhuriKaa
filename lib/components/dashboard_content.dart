import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kukhurikaa/components/circular_progress.dart';
import 'package:kukhurikaa/components/notification_service.dart';
import 'package:kukhurikaa/providers/control_provider.dart';
import 'package:provider/provider.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  List<Map<String, String>> alerts = []; // List to hold multiple alerts
  String? alertTitle;
  String? alertMessage;
  bool isTemperatureControlOn = false;
  bool isHumidityControlOn = false;
  double temperature = 0.0;
  double humidity = 0.0;
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref('test'); // Reference to "test" node
  late Timer _timer;

  // List to track the titles of alerts that have already been notified
  List<String> notifiedAlerts = [];

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

  // Function to check temperature and humidity and trigger alerts/notifications
  void checkAlerts(double temperature, double humidity) {
    // Check temperature alerts
    if (temperature < 30 && !notifiedAlerts.contains('Temperature too low')) {
      alerts.add({
        'title': 'Temperature too low',
        'message': 'Light turned on.',
      });
      // Show notification for low temperature
      showNotification(title: 'Temperature too low', body: 'Light turned on.');
      notifiedAlerts.add('Temperature too low'); // Add to notified list
    } else if (temperature > 33 &&
        !notifiedAlerts.contains('Temperature too high')) {
      alerts.add({
        'title': 'Temperature too high',
        'message': 'Fan turned on.',
      });
      // Show notification for high temperature
      showNotification(title: 'Temperature too high', body: 'Fan turned on.');
      notifiedAlerts.add('Temperature too high'); // Add to notified list
    }

    // Check humidity alerts
    if (humidity < 60 && !notifiedAlerts.contains('Humidity too low')) {
      alerts.add({
        'title': 'Humidity too low',
        'message': 'Cooling fan turned on.',
      });
      // Show notification for low humidity
      showNotification(
          title: 'Humidity too low', body: 'Cooling fan turned on.');
      notifiedAlerts.add('Humidity too low'); // Add to notified list
    } else if (humidity > 70 && !notifiedAlerts.contains('Humidity too high')) {
      alerts.add({
        'title': 'Humidity too high',
        'message': 'LED bulb turned on.',
      });
      // Show notification for high humidity
      showNotification(title: 'Humidity too high', body: 'LED bulb turned on.');
      notifiedAlerts.add('Humidity too high'); // Add to notified list
    }
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

            // Display alerts if any
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
