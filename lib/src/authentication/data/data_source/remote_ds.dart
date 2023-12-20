import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDatasource {
  Future<UserModel> signin({required UserModel users});
  Future<DocumentReference<UserModel>?> signup(Map<String, dynamic> params);
  Future<User> verifyOTP(PhoneAuthCredential credential);
}

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  AuthenticationRemoteDatasourceImpl({required this.firebaseAuth});
  final usersRef = FirebaseFirestore.instance
      .collection('houseRentalAccount')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toMap(),
      );
  @override
  Future<UserModel> signin({required UserModel users}) async {
    throw UnimplementedError();
  }

  @override
  Future<DocumentReference<UserModel>?> signup(
      Map<String, dynamic> params) async {
        
    return usersRef.add(UserModel.fromJson(params));
  }

  @override
  Future<User> verifyOTP(PhoneAuthCredential credential) async {
    final response = await firebaseAuth.signInWithCredential(credential);

  

    if (kDebugMode) {
      print(response.user);
    }
    
      return response.user!;

    
  }
}
