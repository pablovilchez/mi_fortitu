part of 'intra_login_cubit.dart';

@immutable
sealed class IntraLoginState extends Equatable {
  const IntraLoginState();

  @override
  List<Object> get props => [];
}

final class IntraLoginInitial extends IntraLoginState {}

final class IntraLoginLoading extends IntraLoginState {}

final class IntraLoginSuccess extends IntraLoginState {}

final class IntraLoginFailure extends IntraLoginState {
  final String message;
  const IntraLoginFailure(this.message);

  @override
  List<Object> get props => [message];
}