import 'package:dartz/dartz.dart';
import 'package:mi_fortitu/features/home/data/repositories/home_intra_repository.dart';

import '../../../home/domain/failures.dart';
import '../entities/intra_event.dart';

class GetEventsUsecase {
  final repository = HomeIntraRepository();

  Future<Either<Failure, List<IntraEvent>>> call() async {
    final campusEvents = await repository.getIntraCampusEvents();
    final userEvents = await repository.getIntraUserEvents('pvilchez');

    if (campusEvents.isLeft() || userEvents.isLeft()) {
      return Left(ServerDataFailure('Error fetching events'));
    }

    for (final campusEvent in campusEvents.getOrElse(() => [])) {
      final foundEvent = userEvents
          .getOrElse(() => [])
          .firstWhere(
            (userEvent) => userEvent.id == campusEvent.id,
            orElse: () => IntraEvent.empty(),
          );
      if (foundEvent.id != -1) {
        campusEvent.isSubscribed = true;
      }
    }

    return Right(campusEvents.getOrElse(() => []));
  }
}
