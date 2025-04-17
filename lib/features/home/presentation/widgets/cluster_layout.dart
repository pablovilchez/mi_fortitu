import 'package:flutter/material.dart';
import 'package:mi_fortitu/features/home/presentation/widgets/station_user_dialog.dart';

import '../viewmodels/cluster_vm.dart';

class ClusterLayout extends StatelessWidget {
  final List<ClusterVm> clusters;

  const ClusterLayout({super.key, required this.clusters});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: clusters.length,
      controller: PageController(viewportFraction: 0.9),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final cluster = clusters[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(cluster.clusterName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...cluster.rows.map((row) => Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...row.stations.map((station) {
                            final isOccupied = station.user != null;
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: SizedBox(
                                width: 25,
                                height: 30,
                                child: isOccupied
                                    ? GestureDetector(
                                        onTap: () => showDialog(
                                          context: context,
                                          builder: (_) => StationUserDialog(user: station.user!),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: 'assets/images/photo_placeholder.png',
                                            image: station.user!.user.image.small,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(width: 8),
                          Text(row.rowId),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                  ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
