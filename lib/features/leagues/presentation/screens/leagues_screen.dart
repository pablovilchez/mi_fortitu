import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mi_fortitu/core/themes/backgrounds.dart';

import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';

class LeaguesScreen extends StatelessWidget {
  const LeaguesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(tr('leagues.title')),
          actions: [
            IconButton(
              onPressed: () {
                showDevInfoDialog(context, 'leaguesTestInfo');
              },
              icon: const Icon(Icons.adb),
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
                  boxShadow: const [
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
                tr('leagues.message.coming_soon'),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        )
      ),
    );
  }
}
