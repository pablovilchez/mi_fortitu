import 'package:flutter/material.dart';
import 'package:mi_fortitu/features/clusters/presentation/widgets/station_user_dialog.dart';

import '../../../clusters/presentation/viewmodels/cluster_vm.dart';

class ClusterLayout extends StatelessWidget {
  final List<ClusterVm> clusters;

  const ClusterLayout({super.key, required this.clusters});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView.builder(
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _ClusterContent(cluster: cluster),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ClusterContent extends StatelessWidget {
  final ClusterVm cluster;

  const _ClusterContent({required this.cluster});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            cluster.clusterName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
                  stops: [0.0, 0.02, 0.98, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstOut,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(children: cluster.rows.map((row) => _RowWidget(row: row)).toList()),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _RowWidget extends StatelessWidget {
  final RowViewModel row;

  const _RowWidget({required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...row.stations.map((station) => _StationWidget(station: station)),
          const SizedBox(width: 8),
          SizedBox(
            width: 25,
            child: row.rowId != '_' ? Text(row.rowId, textAlign: TextAlign.center) : null,
          ),
        ],
      ),
    );
  }
}

class _StationWidget extends StatelessWidget {
  final StationViewModel station;

  const _StationWidget({required this.station});

  @override
  Widget build(BuildContext context) {
    final user = station.user;
    final isOccupied = user != null;
    final imageUrl = user?.user.imageUrl;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: 25,
        height: 30,
        child:
            isOccupied
                ? GestureDetector(
                  onTap:
                      () => showDialog(
                        context: context,
                        builder: (_) => StationUserDialog(user: user),
                      ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child:
                        hasImage
                            ? FadeInImage.assetNetwork(
                              placeholder: 'assets/images/photo_placeholder.png',
                              image: imageUrl,
                              fit: BoxFit.cover,
                            )
                            : Image.asset('assets/images/photo_placeholder.png', fit: BoxFit.cover),
                  ),
                )
                : Container(
                  decoration: BoxDecoration(
                    border: station.stationId != '_' ? Border.all(color: Colors.grey) : null,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
      ),
    );
  }
}
