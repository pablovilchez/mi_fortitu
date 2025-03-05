import 'package:flutter/material.dart';

class ClustersScreen extends StatelessWidget {
  const ClustersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clusters'),
      ),
      body: const Center(
        child: Text('Clusters Screen'),
      ),
    );
  }
}