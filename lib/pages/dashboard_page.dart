import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kukhurikaa/components/dashboard_content.dart';
import 'package:kukhurikaa/pages/analytics_page.dart';
import 'package:kukhurikaa/pages/news_page.dart';

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
