import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';

abstract class RemoteDatasource {
  Future<UserModel> signin(Map<String, dynamic> params);
  Future<UserModel> signup(Map<String, dynamic> params);
}

class RemoteDatasourceImpl implements RemoteDatasource {
  @override
  Future<UserModel> signin(Map<String, dynamic> params) async{
      throw UnimplementedError();
    }
  Future<UserModel> signup(Map<String, dynamic> params) {
    throw UnimplementedError();
  }
}
