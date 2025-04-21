import 'package:dartz/dartz.dart';

import '../../domain/home_failure.dart';
import '../../presentation/viewmodels/event_viewmodel.dart';
import '../repositories/home_repository.dart';

class GetEventsUsecase {
  final HomeRepository repository;

  GetEventsUsecase(this.repository);

  Future<Either<HomeFailure, List<EventVm>>> call(String loginName, String campusId) async {
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

    final eventsVm = campusEvents.map((event) {
      final isSubscribed = userEvents.any((userEvent) => userEvent.id == event.id);
      return EventVm(
        details: EventDetailsVm.fromEntity(event),
        isSubscribed: isSubscribed,
        isFull: event.nbrSubscribers >= event.maxPeople && event.maxPeople > 0,
      );
    },).toList();

    return Right(eventsVm);
  }
}
