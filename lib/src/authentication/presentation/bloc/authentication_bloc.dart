import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:house_rental/core/usecase/usecase.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/domain/usecases/get_cache_data.dart';
import 'package:house_rental/src/authentication/domain/usecases/signin.dart';
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
  final GetCacheData getCacheData;
  final Signin signin;
  AuthenticationBloc({
    required this.signup,
    required this.firebaseAuth,
    required this.verifyNumber,
    required this.verifyOTP,
    required this.getCacheData,
    required this.signin,
  }) : super(AuthenticationInitial()) {
    on<SignupEvent>((event, emit) async {
      emit(SignupLoading());

      final response = await signup.call(event.users);
      emit(
        response.fold(
          (error) => GenericError(errorMessage: error),
          (response) => SignupLoaded(reference: response),
        ),
      );
    });
    on<PhoneNumberEvent>((event, emit) async {
      emit(
        VerifyPhoneNumberLoading(),
      );

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
      emit(
        CodeSent(
            verifyId: event.verificationId, token: event.forceResendingToken),
      );
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
        emit(
          VerifyOTPLoading(),
        );

        final response = await verifyOTP.call(event.params);

        emit(
          response.fold(
            (error) => VerifyOTPFailed(errorMessage: error),
            (response) => VerifyOTPLoaded(user: response),
          ),
        );

        // // ignore: unused_label
        // transformer:
        // restartable();
      },
    );

    on<GetCacheDataEvent>((event, emit) async {
      final response = await getCacheData.call(
        NoParams(),
      );

      emit(
        response.fold(
          (error) => GetCacheDataError(errorMessage: error),
          (response) => GetCacheDataLoaded(user: response),
        ),
      );
    });

    on<SigninEvent>((event, emit) async {
      emit(SigninLoading());

      final response = await signin.call(event.users);

      emit(
        response.fold((error) => SigninError(errorMessage: error),
            (response) => SigninLoaded(documentReference: response),),
      );
    });
  }
}
