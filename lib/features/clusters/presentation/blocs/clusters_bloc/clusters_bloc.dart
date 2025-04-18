import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../clusters/domain/usecases/get_clusters_usecase.dart';
import '../../mappers/cluster_layout_mapper.dart';
import '../../viewmodels/campus_layout_vm.dart';
import '../../viewmodels/cluster_vm.dart';

part 'clusters_event.dart';
part 'clusters_state.dart';

class ClustersBloc extends Bloc<ClustersEvent, ClustersState> {
  final GetClustersUsecase getCampusClustersUsecase;

  ClustersBloc(this.getCampusClustersUsecase) : super(ClustersInitial()) {
    on<GetCampusClustersEvent>(_onGetCampusClusters);
    on<RefreshClustersEvent>((event, emit) => emit(ClustersInitial()));
  }

  Future<void> _onGetCampusClusters(
    GetCampusClustersEvent event,
    Emitter<ClustersState> emit,
  ) async {
    emit(ClustersLoading());
    final result = await getCampusClustersUsecase.call(event.campusId);
    await result.fold(
      (failure) async {
        emit(ClustersError(failure.toString()));
      },
      (clusters) async {
        final campusLayout = await CampusLayoutVm.fromCampusJson(event.campusId);
        final clusterVMs = ClusterLayoutMapper.map(campusLayout, clusters);
        return clusterVMs.fold(
          (l) => emit(ClustersError(l.toString())),
          (layout) => emit(ClustersSuccess(layout)),
        );
      },
    );
  }


}
