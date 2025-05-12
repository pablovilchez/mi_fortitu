import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mi_fortitu/core/themes/backgrounds.dart';
import 'package:mi_fortitu/features/profiles/presentation/widgets/cursus_profile.dart';

import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';
import '../blocs/user_profile_bloc/user_profile_bloc.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(tr('profile.title')),
          actions: [
            IconButton(
              onPressed: () {
                showDevInfoDialog(context, 'profileTestInfo');
              },
              icon: Icon(Icons.adb),
              color: Colors.red,
            ),
          ],
        ),
        body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileSuccess) {
              final intraProfile = state.profile;
              return CursusProfile(profile: intraProfile);
            }
            return Center(child: Text(tr('profile.message.loading_error')));
          },
        ),
      ),
    );
  }
}
