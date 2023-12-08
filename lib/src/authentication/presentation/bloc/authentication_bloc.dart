import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

      await firebaseAuth.verifyPhoneNumber(
        timeout: const Duration(seconds: 120),
        phoneNumber:"+233240845898",
        verificationCompleted: (PhoneAuthCredential authCredential) async {
          emit(SignupLoading());
        },
        verificationFailed: (FirebaseAuthException exception) {
          emit(GenericError(errorMessage: exception.code));
        },
        codeSent: (String verificationId, int? forceResendingToken) async{




          final response = await signup.call(event.users);

      emit(response.fold((error) => GenericError(errorMessage: error),
          (response) => SignupLoaded(reference: response)));
        },
        codeAutoRetrievalTimeout: (String timeout) {
          // return null;
        },
      );



      
    });
  }


}
