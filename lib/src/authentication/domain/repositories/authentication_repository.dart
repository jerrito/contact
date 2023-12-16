import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
// data/repository/authentication_repository.dart
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<Either<String, DocumentReference<UserModel>?>> signIn(Map<String, dynamic> params);
  Future<Either<String, DocumentReference<UserModel>?>> signUp(Map<String,dynamic> params);
  //Future<Either<String,String phoneNum> signUp(Map<String,dynamic> params);
  //Future<Either<String, DocumentReference<UserModel>?>> signUp(Map<String,dynamic> params);
  //Future<Either<String, DocumentReference<UserModel>?>> signUp(Map<String,dynamic> params);
  //Future<Either<String, DocumentReference<UserModel>?>> signUp(Map<String,dynamic> params);
  Future<Either<String, void>> verifyPhoneNumber(  String phoneNumber,
      Function(String verificationId, int? resendToken) onCodeSent,
      Function(PhoneAuthCredential phoneAuthCredential) onCompleted,
      Function(FirebaseAuthException) onFailed);
}


