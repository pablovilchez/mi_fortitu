import 'package:dartz/dartz.dart';

import '../../../home/domain/failures.dart';
import '../entities/intra_event_entity.dart';
import '../repositories/home_intra_repository.dart';

class GetEventsUsecase {
  final HomeIntraRepository repository;

  GetEventsUsecase({required this.repository});

  Future<Either<HomeFailure, List<IntraEventEntity>>> call(String loginName, String campusId) async {
    final campusEvents = await repository.getIntraCampusEvents(campusId);
    final userEvents = await repository.getIntraUserEvents(loginName);

    if (campusEvents.isLeft() || userEvents.isLeft()) {
      return Left(ServerDataFailure('Error fetching events'));
    }

    for (final campusEvent in campusEvents.getOrElse(() => [])) {
      final foundEvent = userEvents
          .getOrElse(() => [])
          .firstWhere(
            (userEvent) => userEvent.id == campusEvent.id,
            orElse: () => IntraEventEntity.empty(),
          );
      if (foundEvent.id != -1) {
        campusEvent.isSubscribed = true;
      }
    }

    return Right(campusEvents.getOrElse(() => []));
  }
}
