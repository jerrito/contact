part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class SignupLoading extends AuthenticationState {}
class VerifyPhoneNumberLoading extends AuthenticationState {}

class SignupLoaded extends AuthenticationState {
  final UserModel? reference;
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

class SignupComplete extends AuthenticationState {
  const SignupComplete();
}

class CodeSent extends AuthenticationState {
  final String verifyId;
  final int? token;
  const CodeSent({required this.verifyId, required this.token});
}

class CodeCompleted extends AuthenticationState {
  
  final PhoneAuthCredential authCredential;
  const CodeCompleted({required this.authCredential});
}
