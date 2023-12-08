import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:house_rental/core/firebase/firebase.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';

abstract class RemoteDatasource {
  Future<UserModel> signin({required UserModel users});
  Future<DocumentReference<UserModel>?> signup({required UserModel users});
}

class RemoteDatasourceImpl implements RemoteDatasource {
  final FirebaseService firebaseService;

  RemoteDatasourceImpl({required this.firebaseService});
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
      {required UserModel users}) async {
    final user = firebaseService.getUser(phoneNumber: "");
    if (await user == null) {
      print("User already known");
      return null;
    } else {
      return await usersRef.add(users);
    }
  }
}
