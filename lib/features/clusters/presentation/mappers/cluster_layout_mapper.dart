import 'package:dartz/dartz.dart';

import '../../domain/clusters_failure.dart';
import '../../domain/entities/location_entity.dart';
import '../viewmodels/campus_layout_vm.dart';
import '../viewmodels/cluster_vm.dart';

class ClusterLayoutMapper {
  final CampusLayoutVm campusLayout;
  final List<LocationEntity> users;

  ClusterLayoutMapper(this.campusLayout, this.users);

  static Either<MapFailure, List<ClusterVm>> map(
    CampusLayoutVm campusLayout,
    List<LocationEntity> users,
  ) {
    if (campusLayout.campusId == 0) {
      return Left(MapFailure('No campus layout'));
    }
    try {
      final userMap = {
        for (var user in users) user.host: user,
      };
      final clusters =
          campusLayout.clusters.map((clusterLayout) {
            final rows =
                clusterLayout.rows.map((rowLayout) {
                  final stations =
                      rowLayout.stationsId.map((stationsId) {
                        final user =
                            userMap['${clusterLayout.clusterId}${rowLayout.rowId}$stationsId'];

                        return StationViewModel(stationId: stationsId, user: user);
                      }).toList();

                  return RowViewModel(
                    rowId: rowLayout.rowId,
                    stations: stations,
                    starts: rowLayout.startsUp ? 'up' : 'down',
                  );
                }).toList();

            return ClusterVm(
              clusterId: clusterLayout.clusterId,
              clusterName: clusterLayout.clusterName,
              rows: rows,
            );
          }).toList();

      return Right(clusters);
    } catch (e) {
      return Left(MapFailure('Error mapping clusters: $e'));
    }
  }
}
