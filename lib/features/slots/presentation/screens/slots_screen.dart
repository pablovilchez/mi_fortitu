import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/dev_info_widget.dart';

class SlotsScreen extends StatelessWidget {
  const SlotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('home.tiles.eval_slots')),
        actions: [
          IconButton(
            onPressed: () {
              showDevInfoDialog(context, 'slotsTestInfo');
            },
            icon: Icon(Icons.adb),
            color: Colors.red,
          ),
        ],
      ),
      body: const Center(
        child: Text('Evaluation Slots Screen'),
      ),
    );
  }
}