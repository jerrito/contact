import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
abstract class AuthenticationRepository {
  Future<Either<String, DocumentReference<User>?>> signIn({required UserModel users});
  Future<Either<String,DocumentReference<User>?>> signUp({required UserModel users});
}
