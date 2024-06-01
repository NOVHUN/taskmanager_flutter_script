import 'package:flutter/material.dart';
import 'package:taskmanager/database_helper.dart';

class SettingsPage extends StatelessWidget {
  final String version = '1.0.0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Wespaces.png', height: 100), // Correct path
              SizedBox(height: 20),
              Text('Version: $version'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper().clearAllTasks();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('All data cleared')),
                  );
                },
                child: Text('Clear All Data'),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Navigate to terms and conditions page
                },
                child: Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Navigate to privacy policy page
                },
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Powered by Wespace Team', textAlign: TextAlign.center),
      ),
    );
  }
}
