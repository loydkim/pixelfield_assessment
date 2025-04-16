import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF0E1C21);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Scan', style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text(
          'Scan Screen Placeholder',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
