import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../clusters/domain/entities/location_entity.dart';

class StationUserDialog extends StatelessWidget {
  final LocationEntity user;

  const StationUserDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final u = user.user;
    return AlertDialog(
      title: Text(u.firstName, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(u.imageUrl),
          ),
          const SizedBox(height: 12),
          Text('Login: ${u.login}'),
          Text('${tr('profile.kind')}: ${u.kind}'),
          Text("${tr('profile.pool')}: ${tr('lang.months.${u.poolMonth}')} ${u.poolYear}"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Future.delayed(Duration.zero, () {
              if (!context.mounted) return;
              GoRouter.of(context).push('/search-students/${u.login}');
            });
          },
          child: Text(tr('buttons.profile')),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(tr('buttons.close')),
        ),
      ],
    );
  }
}
