import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mi_fortitu/features/profiles/domain/entities/user_entity.dart';

class ProfileUserCard extends StatelessWidget {
  final UserEntity profile;

  const ProfileUserCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final shortYear = profile.poolYear.toString().substring(2);
    final poolMonth = DateFormat.MMMM('en').parseLoose(profile.poolMonth).month;
    final poolDate = DateTime(int.parse(profile.poolYear), poolMonth);
    final date = DateFormat.MMM(tr('language')).format(poolDate).toLowerCase();
    final wallet = NumberFormat.decimalPattern(
      tr('language'),
    ).format(profile.wallet);
    final String pool =
        profile.poolMonth != 'None'
            ? '$date $shortYear'
            : 'No pool';
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 37,
                  backgroundColor: Colors.grey,
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/photo_placeholder.png',
                      placeholderFit: BoxFit.cover,
                      image: profile.image.link,
                      fit: BoxFit.cover,
                      width: 70,
                      height: 70,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.login,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${profile.firstName} ${profile.lastName}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(profile.email, style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 12),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _customColumn(tr('profile.user.kind'), profile.kind),
                _customColumn(tr('profile.user.pool'), pool),
                _customColumn(
                  tr('profile.user.eval_p'),
                  profile.correctionPoint.toString(),
                ),
                _customColumn(tr('profile.user.wallet'), '$wallet ₳'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _customColumn(String title, String value) {
  return Column(
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
      Text(value, style: const TextStyle(fontSize: 14)),
    ],
  );
}
