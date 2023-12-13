import 'package:go_router/go_router.dart';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/domain/usecases/signup.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuth firebaseAuth;
  final Signup signup;
  AuthenticationBloc({required this.firebaseAuth, required this.signup})
      : super(AuthenticationInitial()) {
    on<SignupEvent>((event, emit) async {
      emit(SignupLoading());
      print(event.users.phoneNumber);

      await firebaseAuth.verifyPhoneNumber(
        timeout: const Duration(seconds: 120),
        phoneNumber: event.users.phoneNumber,
        verificationCompleted: (PhoneAuthCredential authCredential) async {
          print("verification completed ${authCredential.smsCode}");
          print(" ${authCredential.verificationId}");
          User? user = FirebaseAuth.instance.currentUser;

          if (authCredential.smsCode != null) {
            try {
              UserCredential credential =
                  await user!.linkWithCredential(authCredential);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'provider-already-linked') {
                await firebaseAuth.signInWithCredential(authCredential);
              }
            }
          }
          emit(const HomePageGet());
        },
        verificationFailed: (FirebaseAuthException exception) {
          if (exception.code == 'invalid-phone-number') {
            emit(const GenericError(errorMessage: 'invalid-phone-number'));
          }
          // emit(GenericError(errorMessage: exception.code));
          print(exception.code);
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          final response = await signup.call(event.users);
          if (emit.isDone) {
            emit(
              response.fold(
                (error) => GenericError(errorMessage: error),
                (response) => SignupLoaded(
                  reference: response,
                  verificationId: verificationId,
                  forceResendingToken: forceResendingToken!,
                ),
              ),
            );
          }
        },
        codeAutoRetrievalTimeout: (String timeout) {
          // return null;
        },
      );
    });
  }
}
