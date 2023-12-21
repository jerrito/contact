import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:house_rental/src/authentication/data/data_source/local_ds.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDatasource {
  Future<QuerySnapshot<UserModel>> signin(Map<String, dynamic> params);
  Future<DocumentReference<UserModel>?> signup(Map<String, dynamic> params);
  Future<User> verifyOTP(PhoneAuthCredential credential);
}

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final AuthenticationLocalDatasource localDatasource;
  AuthenticationRemoteDatasourceImpl(
      {required this.localDatasource, required this.firebaseAuth});
  final usersRef = FirebaseFirestore.instance
      .collection('houseRentalAccount')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toMap(),
      );
  @override
  Future<QuerySnapshot<UserModel>> signin(Map<String, dynamic> params) async {
    //if (numberSignin == false) {
    final response = usersRef
        .where("email", isEqualTo: params["email"])
        .where("password", isEqualTo: params["password"])
        .snapshots()
        .first;
    return response;
  }

  @override
  Future<DocumentReference<UserModel>?> signup(
      Map<String, dynamic> params) async {
    final response = usersRef.add(UserModel.fromJson(params));
    localDatasource.cacheUserData(UserModel.fromJson(params));
    return response;
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
