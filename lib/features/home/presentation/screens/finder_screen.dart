import 'package:flutter/material.dart';

class FinderScreen extends StatelessWidget {
  const FinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finder'),
      ),
      body: Text('Finder Screen'),
    );
  }
}