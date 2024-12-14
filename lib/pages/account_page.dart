import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // For toggling notifications
  bool _notificationsEnabled = true;
  // For password change
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _passwordChanged = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Information Section
            Text("Account Information",
                style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Email: user@example.com"), // Placeholder email
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Logic to edit email
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Password: **********"), // Placeholder password
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Logic to edit password
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Change Password Section
            Text("Change Password",
                style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 10),
            TextField(
              controller: _currentPasswordController,
              decoration: InputDecoration(labelText: "Current Password"),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: "New Password"),
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: "Confirm New Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_newPasswordController.text ==
                      _confirmPasswordController.text) {
                    _passwordChanged = true;
                    // Logic to change password
                  } else {
                    _passwordChanged = false;
                    // Show error
                  }
                });
              },
              child: Text("Save Changes"),
            ),
            if (_passwordChanged)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("Password changed successfully!",
                    style: TextStyle(color: Colors.green)),
              ),
            SizedBox(height: 20),

            // Notification Settings Section
            Text("Notification Settings",
                style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Enable Notifications"),
                Switch(
                  value: _notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Account Deletion Section
            Text("Account Deletion",
                style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(height: 10),
            Text(
                "Permanently delete your account. This action cannot be undone."),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic for account deletion
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Confirm Deletion"),
                    content: Text(
                        "Are you sure you want to permanently delete your account? This cannot be undone."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Cancel deletion
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform account deletion
                          Navigator.of(context).pop();
                        },
                        child: Text("Delete Account"),
                      ),
                    ],
                  ),
                );
              },
              child:
                  Text("Delete Account", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
