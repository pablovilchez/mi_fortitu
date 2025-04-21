import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[400],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/default_leagues.jpg',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              tr('home.messages.coming_soon'),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      )
    );
  }
}
