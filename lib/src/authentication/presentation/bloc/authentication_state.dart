part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class SignupLoading extends AuthenticationState {}

class SignupLoaded extends AuthenticationState {
  final DocumentReference<UserModel>? reference;
  final String verificationId;
  final int forceResendingToken;

  const SignupLoaded({
    required this.verificationId,
    required this.forceResendingToken,
    required this.reference,
  });
}

class GenericError extends AuthenticationState {
  final String errorMessage;
  const GenericError({required this.errorMessage});
}

class HomePageGet extends AuthenticationState {
  const HomePageGet();
}
