import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kukhurikaa/components/circular_progress.dart';
import 'package:kukhurikaa/components/control_card.dart';
import 'package:kukhurikaa/pages/analytics_page.dart';
import 'package:kukhurikaa/pages/news_page.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ScrollController _scrollingController = ScrollController();
  int _selectedIndex = 1; // Set default index to 1 (second tab - Dashboard)
  String _appBarTitle = 'Dashboard'; // Default title for the SliverAppBar

  final List<Widget> _pages = [
    // Placeholder screens for each tab
    AnalyticsPage(),
    DashboardContent(),
    NewsPage(),
  ];

  final List<String> _titles = [
    'Analytics',
    'Dashboard',
    'News',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _appBarTitle =
          _titles[index]; // Update the selected index when a tab is clicked
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast),
          controller: _scrollingController,
          slivers: [
            SliverAppBar(
              expandedHeight: 150.0,
              floating: true,
              centerTitle: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  _appBarTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w800 // Ensure readable text
                      ),
                ),
                background: Container(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings_sharp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SliverFillRemaining(
              child: _pages[_selectedIndex], // Display the selected screen
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
          child: GNav(
            duration: Duration(milliseconds: 300),
            haptic: true,

            color: Colors.black,
            tabActiveBorder: Border.all(
                width: 1, color: Theme.of(context).colorScheme.primary),

            activeColor: Theme.of(context)
                .colorScheme
                .primary, // Red color for active icon
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            gap: 8,
            onTabChange: _onItemTapped,
            selectedIndex: _selectedIndex,
            tabs: const [
              GButton(
                icon: Icons.analytics,
                text: 'Analytics',
              ),
              GButton(
                icon: Icons.dashboard,
                text: 'Dashboard',
              ),
              GButton(
                icon: Icons.newspaper,
                text: 'News',
              ),
            ],
          ),
        ));
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  int _temperature = 24; // Default temperature value
  int _humidity = 80; // Default humidity value

  void _incrementTemperature() {
    setState(() {
      _temperature++;
    });
  }

  void _decrementTemperature() {
    setState(() {
      if (_temperature > 0) _temperature--;
    });
  }

  void _incrementHumidity() {
    setState(() {
      if (_humidity < 100) _humidity++;
    });
  }

  void _decrementHumidity() {
    setState(() {
      if (_humidity > 0) _humidity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularProgress(
                  title: "Temperature",
                  progress: _temperature.toDouble(),
                  unit: "°C",
                  foregroundColor: Colors.red,
                ),
                SizedBox(
                  width: 20,
                ),
                CircularProgress(
                  title: "Humidity",
                  progress: _humidity.toDouble(),
                  unit: '%',
                  foregroundColor: Colors.blue,
                ),
              ],
            ),
            // Row for temperature and humidity control
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ControlCard(
                  title: 'Target Temperature',
                  value: '$_temperature°C',
                  onIncrement: _incrementTemperature,
                  onDecrement: _decrementTemperature,
                ),
                SizedBox(width: 16),
                ControlCard(
                  title: 'Target Humidity',
                  value: '$_humidity%',
                  onIncrement: _incrementHumidity,
                  onDecrement: _decrementHumidity,
                ),
              ],
            ),
            // Example list of items (can be a list of recent alerts, logs, etc.)
            ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text('Alert: High Temperature'),
              subtitle: Text('The temperature has exceeded the safe limit!'),
            ),
            ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text('Alert: Low Humidity'),
              subtitle: Text('The humidity is below the recommended level!'),
            ),
          ],
        ),
      ),
    );
  }
}
