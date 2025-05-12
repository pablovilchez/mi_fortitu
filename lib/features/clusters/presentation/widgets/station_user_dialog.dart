import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../clusters/domain/entities/location_entity.dart';

class StationUserDialog extends StatelessWidget {
  final LocationEntity user;

  const StationUserDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final userData = user.user;
    final poolMonth = DateFormat.MMMM('en').parseLoose(userData.poolMonth).month;
    final poolDate = DateTime(int.parse(userData.poolYear), poolMonth);
    final date = DateFormat.MMM(tr('language')).format(poolDate).toLowerCase();

    return AlertDialog(
      title: Text(userData.firstName, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(userData.imageUrl),
          ),
          const SizedBox(height: 12),
          Text('Login: ${userData.login}'),
          Text('${tr('profile.user.kind')}: ${userData.kind}'),
          Text("${tr('profile.user.pool')}: $date ${userData.poolYear}"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Future.delayed(Duration.zero, () {
              if (!context.mounted) return;
              GoRouter.of(context).push('/search-students/${userData.login}');
            });
          },
          child: Text(tr('clusters.button.profile')),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(tr('clusters.button.close')),
        ),
      ],
    );
  }
}
