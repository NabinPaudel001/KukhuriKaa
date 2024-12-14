import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kukhurikaa/providers/sensor_data_provider.dart'; // Import SensorDataProvider

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  Timer? _timer;
  List<double> temperatureData = [];
  List<double> humidityData = [];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final sensorDataProvider =
          Provider.of<SensorDataProvider>(context, listen: false);

      // Add the current temperature and humidity to the data lists
      temperatureData.add(sensorDataProvider.temperature);
      humidityData.add(sensorDataProvider.humidity);

      // Keep data list limited to 100 items for performance
      if (temperatureData.length > 100) {
        temperatureData.removeAt(0);
      }
      if (humidityData.length > 100) {
        humidityData.removeAt(0);
      }

      setState(() {}); // Trigger a rebuild to update the chart
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sensorDataProvider = Provider.of<SensorDataProvider>(context);

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Temperature vs Time",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        temperatureData.length,
                        (index) => FlSpot(
                          index.toDouble(),
                          temperatureData[index],
                        ),
                      ),
                      isCurved: true,
                      barWidth: 3,
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.orange],
                      ),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(show: true),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Humidity vs Time",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        humidityData.length,
                        (index) => FlSpot(
                          index.toDouble(),
                          humidityData[index],
                        ),
                      ),
                      isCurved: true,
                      barWidth: 3,
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.lightBlueAccent],
                      ),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(show: true),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
