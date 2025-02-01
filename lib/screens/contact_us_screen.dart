import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'If you have any questions, feedback, or need support, feel free to reach out to us. '
              'We are here to help!',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 24),
            const Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            const ListTile(
              leading: Icon(Icons.email, color: Colors.blueAccent),
              title: Text('Email'),
              subtitle: Text('support@example.com'),
            ),
            const ListTile(
              leading: Icon(Icons.phone, color: Colors.blueAccent),
              title: Text('Phone'),
              subtitle: Text('+1 (123) 456-7890'),
            ),
            const ListTile(
              leading: Icon(Icons.location_on, color: Colors.blueAccent),
              title: Text('Address'),
              subtitle: Text('123 Main St, City, Country'),
            ),
          ],
        ),
      ),
    );
  }
}