import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/domain/usecases/signup.dart';
import 'package:house_rental/src/authentication/domain/usecases/verify_number.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final auth.FirebaseAuth firebaseAuth;
  final Signup signup;
  final VerifyPhoneNumber verifyNumber;
  AuthenticationBloc(
      {required this.signup,
      required this.firebaseAuth,
      required this.verifyNumber})
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

      final response = await verifyNumber.verifyPhoneNumber(
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
    // @override
    // Stream<AuthenticationState> mapEventToState(
    //   AuthenticationEvent event,
    // ) async* {
    //   if (event is SignupLoadingEvent) {
    //     yield SignupLoading();
    //   }
    //   if (event is SignupEvent) {
    //     //firebaseRun(event.users);
    //   }
    //   if (event is SignupCompleteEvent) {
    //     yield const SignupComplete();
    //   }
    //   if (event is SignupErrorEvent) {
    //     yield GenericError(errorMessage: event.error);
    //   }
    //   if (event is CodeSentEvent) {
    //     yield SignupLoaded(
    //         verificationId: event.verificationId,
    //         forceResendingToken: event.forceResendingToken,
    //         reference: event.users);
    //   }
    // }

    // void firebaseRun(UserModel user) async {
    //   add(const SignupLoadingEvent());
    //   await firebaseAuth.verifyPhoneNumber(
    //     timeout: const Duration(seconds: 120),
    //     phoneNumber: user.phoneNumber,
    //     verificationCompleted: (PhoneAuthCredential authCredential) async {
    //       //print("verification completed ${authCredential.smsCode}");
    //       // print(" ${authCredential.verificationId}");
    //       User? user = FirebaseAuth.instance.currentUser;

    //       if (authCredential.smsCode != null) {
    //         try {
    //           UserCredential credential =
    //               await user!.linkWithCredential(authCredential);
    //         } on FirebaseAuthException catch (e) {
    //           if (e.code == 'provider-already-linked') {
    //             await firebaseAuth.signInWithCredential(authCredential);
    //           }
    //         }
    //       }
    //       add(const SignupCompleteEvent());
    //     },
    //     verificationFailed: (FirebaseAuthException exception) {
    //       if (exception.code == 'invalid-phone-number') {
    //         //  emit(const GenericError(errorMessage: 'invalid-phone-number'));
    //       }
    //       add(SignupErrorEvent(error: exception.code));
    //       //print(exception.code);
    //     },
    //     codeSent: (String verificationId, int? forceResendingToken) {
    //       add(
    //         CodeSentEvent(
    //             forceResendingToken: forceResendingToken!,
    //             verificationId: verificationId,
    //             users: user),
    //       );
    //     },
    //     codeAutoRetrievalTimeout: (String timeout) {
    //       // return null;
    //     },
    //);
  }
}
