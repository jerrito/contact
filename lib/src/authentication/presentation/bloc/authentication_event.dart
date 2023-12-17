part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class SignupEvent extends AuthenticationEvent {
  final Map<String,dynamic> users;

  const SignupEvent({required this.users});
}

final class SignupCompleteEvent extends AuthenticationEvent {
  const SignupCompleteEvent();
}

final class SignupLoadingEvent extends AuthenticationEvent {
  const SignupLoadingEvent();
}

final class SignupErrorEvent extends AuthenticationEvent {
  final String error;
  const SignupErrorEvent({required this.error});
}

final class PhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumber;

 const PhoneNumberEvent({required this.phoneNumber});
}

final class CodeSentEvent extends AuthenticationEvent {
  final String verificationId;
  final int forceResendingToken;
  final UserModel users;

  const CodeSentEvent(
      {required this.forceResendingToken,
      required this.verificationId,
      required this.users});
}
