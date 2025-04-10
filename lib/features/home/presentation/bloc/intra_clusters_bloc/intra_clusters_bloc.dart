import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/get_clusters_usecase.dart';
import '../../mappers/cluster_layout_mapper.dart';
import '../../viewmodels/campus_layout_vm.dart';
import '../../viewmodels/cluster_vm.dart';

part 'intra_clusters_event.dart';
part 'intra_clusters_state.dart';

class IntraClustersBloc extends Bloc<IntraClustersEvent, IntraClustersState> {
  final GetClustersUsecase getCampusClustersUsecase;

  IntraClustersBloc({required this.getCampusClustersUsecase}) : super(IntraClustersInitial()) {
    on<GetCampusClustersEvent>(_onGetCampusClusters);
  }

  Future<void> _onGetCampusClusters(
    GetCampusClustersEvent event,
    Emitter<IntraClustersState> emit,
  ) async {
    emit(IntraClustersLoading());
    final result = await getCampusClustersUsecase.call(event.campusId);
    result.fold((failure) => emit(IntraClustersError(failure.toString())), (clusters) {
      final campusLayout = CampusLayoutVm.fromCampusJson(event.campusId);
      final clusterVMs = ClusterLayoutMapper.map(campusLayout, clusters);
      return clusterVMs.fold(
        (l) => emit(IntraClustersError(l.toString())),
        (layout) => emit(IntraClustersSuccess(layout)),
      );
    });
  }
}
