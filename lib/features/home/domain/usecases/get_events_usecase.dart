import 'package:dartz/dartz.dart';

import '../../domain/home_failure.dart';
import '../../presentation/viewmodels/event_viewmodel.dart';
import '../entities/reg_event_data_entity.dart';
import '../repositories/home_repository.dart';

class GetEventsUsecase {
  final HomeRepository repository;

  GetEventsUsecase(this.repository);

  Future<Either<HomeFailure, List<EventVm>>> call(String loginName, int campusId) async {
    final campusEventsResult = await repository.getCampusEvents(campusId);

    if (campusEventsResult.isLeft()) {
      return Left(campusEventsResult.swap().getOrElse(() => UnexpectedFailure()));
    }

    final campusEvents = campusEventsResult.getOrElse(() => []);

    final userEventsResult = await repository.getUserEvents(loginName);
    if (userEventsResult.isLeft()) {
      return Left(userEventsResult.swap().getOrElse(() => UnexpectedFailure()));
    }

    final userEvents = userEventsResult.getOrElse(() => []);

    campusEvents.removeWhere((event) => event.beginAt.isBefore(DateTime.now()));
    campusEvents.sort((a, b) => a.beginAt.compareTo(b.beginAt));

    final currentEvents = campusEvents.map((campusEvent) {
      final eventMatched = userEvents.firstWhere(
            (reg) => reg.eventId == campusEvent.eventId,
        orElse: () => RegEventDataEntity(id: -1, eventId: -1, userId: -1),
      );

      final isSubscribed = eventMatched.id > 0;

      return EventVm(
        details: EventDetailsVm.fromEntity(campusEvent),
        isFull: campusEvent.nbrSubscribers >= campusEvent.maxPeople && campusEvent.maxPeople > 0,
        status: isSubscribed ? EventStatus.subscribed : EventStatus.notSubscribed,
        userId: eventMatched.userId,
        registerId: eventMatched.id,
      );
    },).toList();

    return Right(currentEvents);
  }
}
