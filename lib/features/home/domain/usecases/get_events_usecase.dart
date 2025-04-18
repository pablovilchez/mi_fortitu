import 'package:dartz/dartz.dart';

import '../../../home/domain/failures.dart';
import '../entities/event_entity.dart';
import '../repositories/home_intra_repository.dart';

class GetEventsUsecase {
  final HomeIntraRepository repository;

  GetEventsUsecase({required this.repository});

  Future<Either<HomeFailure, List<EventEntity>>> call(String loginName, String campusId) async {
    final campusEvents = await repository.getIntraCampusEvents(campusId);
    final userEvents = await repository.getIntraUserEvents(loginName);

    if (campusEvents.isLeft()) {
      return Left(ServerDataFailure('Error fetching campus events: ${campusEvents.fold((l) => l.toString(), (r) => '')}'));
    }
    if (userEvents.isLeft()) {
      return Left(ServerDataFailure('Error fetching user events: ${userEvents.fold((l) => l.toString(), (r) => '')}'));
    }

    for (final campusEvent in campusEvents.getOrElse(() => [])) {
      final foundEvent = userEvents
          .getOrElse(() => [])
          .firstWhere(
            (userEvent) => userEvent.id == campusEvent.id,
            orElse: () => EventEntity.empty(),
          );
      if (foundEvent.id != -1) {
        campusEvent.isSubscribed = true;
      }
    }

    return Right(campusEvents.getOrElse(() => []));
  }
}
