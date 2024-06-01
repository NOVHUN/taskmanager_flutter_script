import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'models/task_model.dart';
import 'pages/task_provider.dart';
import 'pages/home_page.dart';
import 'pages/history_page.dart';
import 'pages/settings_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/report_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider()..loadTasks(),
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        debugShowCheckedModeBanner: false,
        home: MainLayout(),
        routes: {
          '/history': (context) => HistoryPage(),
          '/settings': (context) => SettingsPage(),
          '/dashboard': (context) => DashboardPage(),
          '/report/day': (context) => ReportPage(reportType: 'day'),
          '/report/week': (context) => ReportPage(reportType: 'week'),
          '/report/month': (context) => ReportPage(reportType: 'month'),
          '/report/year': (context) => ReportPage(reportType: 'year'),
        },
      ),
    );
  }
}

class MainLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor:
            Colors.deepPurple, // Custom color for AppBar background
        leading: IconButton(
          icon: Icon(Icons.menu,
              color: Colors.white), // Adjust icon color for better contrast
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          'Task Manager',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(150, 0, 0, 0),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history,
                color: Colors.white), // Icon with adjusted color
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
          IconButton(
            icon: Icon(Icons.settings,
                color: Colors.white), // Consistent icon color
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
        elevation: 4.0, // Slight elevation for a subtle shadow
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purple[700]!,
                    Colors.purple[300]!
                  ], // Gradient effect from dark to light purple
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.date_range, // Icon representing the task by date
                      color: Colors.white,
                      size: 48.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Show Tasks by Date',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            // Adding shadow to text for better visibility on the gradient
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Color.fromARGB(150, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard,
                  color: Colors.deepPurple), // Adding an icon
              title: Text('Dashboard',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
                // Consider adding some haptic feedback or visual feedback on tap
              },
            ),
            ListTile(
              leading: Icon(Icons.today,
                  color: Colors.deepPurple), // Icon for Task of the Day
              title: Text('Task of Day',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushNamed(context, '/report/day');
              },
            ),
            ListTile(
              leading: Icon(Icons.date_range,
                  color: Colors.deepPurple), // Icon for Task of the Week
              title: Text('Task of Week',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushNamed(context, '/report/week');
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today,
                  color: Colors.deepPurple), // Icon for Task of the Month
              title: Text('Task of Month',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushNamed(context, '/report/month');
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate_outlined,
                  color: Colors.deepPurple), // Icon for Task of the Year
              title: Text('Task of Year',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushNamed(context, '/report/year');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  color: Colors.deepPurple), // Icon for Settings
              title: Text('Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: HomePage(),
    );
  }
}
