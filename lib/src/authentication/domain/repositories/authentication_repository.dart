import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
abstract class AuthenticationRepository {
  Future<Either<String, User>> signIn(Map<String,dynamic> params);
  Future<Either<String, User>> signUp(Map<String,dynamic> params);
}
