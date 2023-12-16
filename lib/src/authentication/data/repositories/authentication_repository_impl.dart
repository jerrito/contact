import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:house_rental/core/firebase/firebase.dart';
import 'package:house_rental/core/network_info.dart/network_info.dart';
import 'package:house_rental/src/authentication/data/data_source/remote_ds.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final RemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;
  final FirebaseService firebaseService;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthenticationRepositoryImpl({
    required this.firebaseService,
    required this.networkInfo,
    required this.remoteDatasource,
  });
  @override
  Future<Either<String, DocumentReference<UserModel>?>> signIn(
     Map<String,dynamic> params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.signup(params);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  @override
  Future<Either<String, DocumentReference<UserModel>?>> signUp(
      Map<String,dynamic> params) async {
    if (await networkInfo.isConnected) {
      final user =
          await firebaseService.getUser(phoneNumber: params["phone_number"]);
      if (user != null) {
        // print("User already known");
        return const Left("User already registered");
      } else {
        try {
          final response = await remoteDatasource.signup(params);

          return Right(response);
        } catch (e) {
          return Left(e.toString());
        }
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  @override
  Future<Either<String, void>> verifyPhoneNumber(
      String phoneNumber,
      Function(String verificationId, int? resendToken) onCodeSent,
      Function(PhoneAuthCredential phoneAuthCredential) onCompleted,
      Function(FirebaseAuthException) onFailed) async {
    try {
      return Right(await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async{
        await  onCompleted(credential);
        },
        verificationFailed: (FirebaseAuthException e) async{
        await  onFailed(e);
          // return Left(e.message);
        },
        codeSent: (String verificationId, int? resendToken) async{
         await onCodeSent(verificationId, resendToken);

          // onCodeSent(PhoneAuthCredential(
          //   providerId: '',
          //   signInMethod: '',
          //   verificationId: verificationId,
          //   smsCode: '',
          // ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto retrieval timeout
        },
      ));
    } catch (e) {
      onFailed(FirebaseAuthException(message: e.toString(), code: 'UNKNOWN'));
      return Left(e.toString());
    }
  }
}
