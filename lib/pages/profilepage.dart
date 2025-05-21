import 'package:flutter/material.dart';

class MessengerMenuPage extends StatefulWidget {
  const MessengerMenuPage({super.key});

  @override
  State<MessengerMenuPage> createState() => _MessengerMenuPageState();
}

class _MessengerMenuPageState extends State<MessengerMenuPage> {
  bool activeStatus = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Me',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/tarq.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Tareq KH',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Email@gmail.com',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),

            const SizedBox(height: 10),

         
            Container(
              color: Colors.white,
              child: SwitchListTile(
                title: const Text('Active Status'),
                value: activeStatus,
                onChanged: (val) {
                  setState(() {
                    activeStatus = val;
                  });
                },
                secondary: Icon(
                  Icons.circle,
                  color: activeStatus ? Colors.green : Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 10),

        
            menuItem(Icons.message_outlined, 'Message Requests'),
            menuItem(Icons.notifications_outlined, 'Notifications & Sounds'),
            menuItem(Icons.lock_outline, 'Privacy'),
            menuItem(Icons.settings_outlined, 'Account Settings'),
            menuItem(Icons.info_outline, 'Help'),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget menuItem(IconData icon, String title) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: ListTile(
            leading: Icon(icon, color: Colors.black),
            title: Text(title),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
     
            },
          ),
        ),
        const Divider(height: 1, thickness: 0.5),
      ],
    );
  }
}
