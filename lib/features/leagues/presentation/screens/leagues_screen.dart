import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/dev_info_widget.dart';

class LeaguesScreen extends StatelessWidget {
  const LeaguesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('home.tiles.leagues')),
        actions: [
          IconButton(
            onPressed: () {
              showDevInfoDialog(context, 'leaguesTestInfo');
            },
            icon: Icon(Icons.adb),
            color: Colors.red,
          ),
        ],
      ),
      body: Text('Leagues Screen'),
    );
  }
}
