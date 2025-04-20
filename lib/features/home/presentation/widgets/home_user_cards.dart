import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../../profiles/presentation/viewmodels/intra_profile_summary_vm.dart';
import '../../../../core/presentation/widgets/dialogs/dev_info_widget.dart';


class HomeUserCards extends StatelessWidget {
  final IntraProfileSummaryVM profile;

  const HomeUserCards({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(profile.imageUrl),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              profile.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 75, child: Text(profile.grade)),
                        Text(
                          'Lvl. ${profile.level.truncate().toString()}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 100,
                          height: 5,
                          child: LinearProgressIndicator(
                            value: profile.level - profile.level.truncate(),
                            backgroundColor: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                            valueColor: AlwaysStoppedAnimation(Colors
                                .lightBlue),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${((profile.level * 100).truncate() % 100)
                              .toString()}%',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 30,
              top: 0,
              child: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  GoRouter.of(context).push('/settings');
                },
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(onPressed: (){
                showDevInfoDialog(context, 'homeTestInfo');
              }, icon: Icon(Icons.adb),
                color: Colors.red,)
            ),
          ],
        ),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      Text(
                        '₳ Wallet',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        profile.wallet.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.grey[300]),
                SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      Text(
                        'Ev. Points',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        profile.correctionPoints.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.grey[300]),
                SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      Text(
                        'Ranking',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        '0', // TODO: Add ranking
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}