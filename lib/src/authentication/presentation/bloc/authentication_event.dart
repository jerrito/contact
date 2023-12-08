part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class SignupEvent extends AuthenticationEvent {
  final UserModel users;

  const SignupEvent({required this.users});
}
