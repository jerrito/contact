import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';

abstract class RemoteDatasource {
  Future<UserModel> signin({required UserModel users});
  Future<DocumentReference<UserModel>?> signup(Map<String, dynamic> params);
}

class RemoteDatasourceImpl implements RemoteDatasource {
  RemoteDatasourceImpl();
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
}
