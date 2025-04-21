import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_fortitu/features/settings/domain/usecases/logout_usecase.dart';

import '../../../../core/helpers/preferences_helper.dart';
import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';

class SettingsScreen extends StatelessWidget {
  final LogoutUsecase _logoutUsecase = GetIt.I();

  SettingsScreen({super.key});

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
            ListTile(
              title: Text(tr('settings.logout')),
              trailing: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  _logoutUsecase();
                  GoRouter.of(context).go('/auth');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
