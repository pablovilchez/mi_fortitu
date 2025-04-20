import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/helpers/preferences_helper.dart';
import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    final preferences = PreferencesHelper();

    return Scaffold(
      appBar: AppBar(title: Text(tr('settings.title')), actions: [
        IconButton(
          onPressed: () {
            showDevInfoDialog(context, 'settingsTestInfo');
          },
          icon: Icon(Icons.adb),
          color: Colors.red,
        ),
      ],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(tr('settings.language')),
              trailing: DropdownButton<Locale>(
                value: currentLocale,
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    EasyLocalization.of(context)?.setLocale(newLocale);
                    preferences.setLanguage(newLocale.languageCode);
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: Locale('en'),
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: Locale('es'),
                    child: Text('Español'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
