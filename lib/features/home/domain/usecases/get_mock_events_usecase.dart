import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/data/repositories/home_intra_repository.dart';

import '../../../home/domain/failures.dart';
import '../entities/intra_event.dart';

class GetMockEventsUsecase {
  final repository = HomeIntraRepository();

  Future<Either<Failure, List<IntraEvent>>> call() async {
    try {
      final List<IntraEvent> campusEvents =
          await repository.getMockIntraCampusEvents();
      final List<IntraEvent> userEvents = await repository
          .getMockIntraUserEvents('pvilchez');
      for (final campusEvent in campusEvents) {
        final foundEvent = userEvents.firstWhere(
          (userEvent) => userEvent.id == campusEvent.id,
          orElse: () => IntraEvent.empty(),
        );
        if (foundEvent.id != -1) {
          campusEvent.isSubscribed = true;
        }
      }
      return Right(campusEvents);
    } catch (e) {
      return Left(ServerDataFailure(e.toString()));
    }
  }
}
