import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:house_rental/core/firebase/firebase.dart';
import 'package:house_rental/core/network_info.dart/network_info.dart';
import 'package:house_rental/src/authentication/data/data_source/remote_ds.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;
  final FirebaseService firebaseService;
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;

  AuthenticationRepositoryImpl({
    required this.firebaseService,
    required this.networkInfo,
    required this.remoteDatasource,
  });
  @override
  Future<Either<String, DocumentReference<UserModel>?>> signIn(
      Map<String, dynamic> params) async {
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
  Future<Either<String, DocumentReference<User>?>> signUp(
      Map<String, dynamic> params) async {
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
      Function(auth.PhoneAuthCredential phoneAuthCredential) onCompleted,
      Function(auth.FirebaseAuthException) onFailed) async {
    final user = await firebaseService.getUser(phoneNumber: phoneNumber);
    print(user?.phoneNumber);
    if (user?.phoneNumber != null) {
      // print("User already known");
      return const Left("User already registered");
    } else {
      try {
        return Right(await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 120),
          verificationCompleted: (auth.PhoneAuthCredential credential) async {
            await onCompleted(credential);
          },
          verificationFailed: (auth.FirebaseAuthException e) async {
            await onFailed(e);
            // return Left(e.message);
          },
          codeSent: (String verificationId, int? resendToken) async {
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
        onFailed(
            auth.FirebaseAuthException(message: e.toString(), code: 'UNKNOWN'));
        return Left(e.toString());
      }
    }
  }

  @override
  Future<Either<String, auth.UserCredential>> verifyOTP(
      auth.AuthCredential credential) async {
    if (await networkInfo.isConnected) {
      final response = await remoteDatasource.verifyOTP(credential);
      return Right(response);
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }
}
