import 'package:flutter/material.dart';

class EvalSlotsScreen extends StatelessWidget {
  const EvalSlotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Evaluation Slots'),
      ),
      body: const Center(
        child: Text('Evaluation Slots Screen'),
      ),
    );
  }
}