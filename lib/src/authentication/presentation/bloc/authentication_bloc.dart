import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/domain/usecases/signup.dart';
import 'package:house_rental/src/authentication/domain/usecases/verify_number.dart';
import 'package:house_rental/src/authentication/domain/usecases/verify_otp.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final auth.FirebaseAuth firebaseAuth;
  final Signup signup;
  final VerifyPhoneNumber verifyNumber;
  final VerifyOTP verifyOTP;
  AuthenticationBloc(
      {required this.signup,
      required this.firebaseAuth,
      required this.verifyNumber,
      required this.verifyOTP})
      : super(AuthenticationInitial()) {
    // on<PhoneNumberEvent>((event, emit) async {
    //   emit(VerifyPhoneNumberLoading());
    //   await verifyNumber.verifyPhoneNumber(
    //       event.phoneNumber,
    //       (verificationId, resendToken) async =>
    //           emit(CodeSent(verifyId: verificationId, token: resendToken)),
    //       (auth.PhoneAuthCredential phoneAuthCredential) async =>
    //           emit(CodeCompleted(authCredential: phoneAuthCredential)),
    //       (p0) => emit(GenericError(errorMessage: p0.message!)));
    // });

    on<SignupEvent>((event, emit) async {
      emit(SignupLoading());

      final response = await signup.call(event.users);
      emit(response.fold((error) => GenericError(errorMessage: error),
          (response) => SignupLoaded(reference: response)));
    });
    on<PhoneNumberEvent>((event, emit) async {
      emit(VerifyPhoneNumberLoading());

      await verifyNumber.verifyPhoneNumber(
        event.phoneNumber,
        (verificationId, resendToken) => add(
          CodeSentEvent(
            forceResendingToken: resendToken!,
            verificationId: verificationId,
          ),
        ),
        (phoneAuthCredential) => add(
          VerificationCompleteEvent(phoneAuthCredential: phoneAuthCredential),
        ),
        (p0) => add(
          PhoneNumberErrorEvent(error: p0.message!),
        ),
      );
    });

    //!Code Sent
    on<CodeSentEvent>((event, emit) async {
      emit(CodeSent(
          verifyId: event.verificationId, token: event.forceResendingToken));
    });

    on<VerificationCompleteEvent>((event, emit) {
      emit(
        CodeCompleted(authCredential: event.phoneAuthCredential),
      );
    });
    on<PhoneNumberErrorEvent>((event, emit) {
      emit(
        GenericError(errorMessage: event.error),
      );
    });

    on<VerifyOTPEvent>(
      (event, emit) async {
        emit(VerifyOTPLoading());

        final response = await verifyOTP.call(event.params);

        emit(response.fold((error) => VerifyOTPFailed(errorMessage: error),
            (response) => VerifyOTPLoaded(credential: response)));

        // ignore: unused_label
        transformer:restartable();
      },
    );
   
  }
}
