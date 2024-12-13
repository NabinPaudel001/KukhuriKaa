import 'dart:async';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kukhurikaa/providers/control_provider.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Start a Timer to update the graph every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final controlProvider =
          Provider.of<ControlProvider>(context, listen: false);

      // Add current temperature and humidity to their respective data lists
      controlProvider.addTemperatureData(controlProvider.temperature);
      controlProvider.addTemperatureData(controlProvider.temperature);
      if (controlProvider.temperatureData.length > 100) {
        controlProvider.temperatureData.removeAt(0);
      }
      controlProvider.addHumidityData(controlProvider.humidity);
      controlProvider.addHumidityData(controlProvider.humidity);
      if (controlProvider.humidityData.length > 100) {
        controlProvider.humidityData.removeAt(0);
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controlProvider = Provider.of<ControlProvider>(context);

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
                        controlProvider.temperatureData.length,
                        (index) => FlSpot(
                          index.toDouble(),
                          controlProvider.temperatureData[index],
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
                        controlProvider.humidityData.length,
                        (index) => FlSpot(
                          index.toDouble(),
                          controlProvider.humidityData[index],
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
