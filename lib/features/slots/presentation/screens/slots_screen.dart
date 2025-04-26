import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mi_fortitu/core/themes/backgrounds.dart';

import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';

class SlotsScreen extends StatelessWidget {
  const SlotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
      ),
    );
  }
}