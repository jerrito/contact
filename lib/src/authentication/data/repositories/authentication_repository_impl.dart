import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:house_rental/core/network_info.dart/network_info.dart';
import 'package:house_rental/src/authentication/data/data_source/remote_ds.dart';
import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:house_rental/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final RemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
  });
  @override
  Future<Either<String, DocumentReference<User>?>> signIn({required UserModel users}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.signup(users:users);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  @override
  Future<Either<String,DocumentReference<User>?>> signUp({required UserModel users}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.signup(users: users);

        return Right(response);
      } catch (e) {
        return Left(e.toString());
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }
}
