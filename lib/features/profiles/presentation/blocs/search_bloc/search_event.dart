part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class GetSearchProfileEvent extends SearchEvent {
  final String loginName;

  GetSearchProfileEvent(this.loginName);
}